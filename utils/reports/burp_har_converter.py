"""The burp parser for xml data (REQUESTS EXPORTED IN BASE64)"""
import base64
import csv
from typing import List
from html2text import HTML2Text
from bs4 import BeautifulSoup
import mistletoe
import xmltodict
import re

import sys



def log_info(s):
    print(f"[+] {s}")

def usage():
    print("Usage: burp_har_converter.py <burp-results-file> <har-session-where-take-entries>")
    sys.exit(-1)

# TODO mantenere liste? Per ora non le mantiene...
# TODO replace \" with " ?
def html2plain(html):
    if html:
        # HTML to Markdown
        parser = HTML2Text()
        parser.ignore_images = True
        parser.ignore_anchors = True
        parser.body_width = 0
        md = parser.handle(html)
        # Normalise custom lists
        md = re.sub(r'(^|\n) ? ? ?\\?[•·–-—-*]( \w)', r'\1  *\2', md)
        # Convert back into HTML
        html_simple = mistletoe.markdown(md)
        html_simple_lists = html_simple.replace("\n<li>", "\n  - ").replace("<ul>", ""). replace("</ul>","").replace("</li>","")
        # Convert to plain text
        soup = BeautifulSoup(html_simple_lists, 'html.parser')
        text = soup.getText()
        # Strip off table formatting
        text = re.sub(r'(^|\n)\|\s*', r'\1', text)
        # Strip off extra emphasis
        text = re.sub(r'\*\*', '', text)
        # Remove trailing whitespace and leading newlines
        text = re.sub(r' *$', '', text)
        text = re.sub(r'\n\n+', r'\n\n', text)
        text = re.sub(r'^\n+', '', text)
        return text
    else:
        return html



# split http headers
def split_http(req_or_resp):
    header, body = req_or_resp.split("\r\n\r\n",1)
    splitted_header = header.split("\r\n")
    if len(body) > 500:
        body = body[:500] + " [...]"
    splitted = splitted_header
    #splitted.append("\n")
    splitted.append(body)
    return splitted

# Check if a string is binary
def is_binary_string(s):
    try:
        s.encode('ascii')
    except UnicodeEncodeError:
        return True
    return False



class BurpXMLParser:

    def __init__(self, report_filename: str, to_store: str):
        self.__report_filename = report_filename
        self.__vulnerabilities_information = {} 
        self.__lang = "en"
        self.to_store = to_store

    # open the xml report given by burp and convert it into a dictionary object 
    def __parse_xml_report(self):
        with open(self.__report_filename, 'r') as xml_file:
            self.__report_dict = xmltodict.parse(xml_file.read())

    
    # def __read_vulnerability_information(self):
    #     self.__vulnerabilities_information = VulnerabilityInformationReader.read_burp_vulnerability_information()


    def write_data(self, data):
        with open(self.to_store, 'w') as f: 
            fieldnames = data[0].keys()
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writerows(data)

    def get_cleaned_http_data(self, request_or_response: str):
        """Clean the http b64 of Burp

        Args:
            request_or_response (str): The Burp string in b64 

        Returns:
            str: The cleaned string
        """
        data = split_http(base64.b64decode(request_or_response).decode('latin-1'))
        data = "\n".join(data)
        data = "BINARY DATA" if is_binary_string(data) else data
        return data
        
    def extract_evidences(self, issue):
        evidences = []
        index = 1
        # vuln_location = issue.get("location","")
        vuln_description = html2plain(issue.get("issueDetail","")) #html
        if(issue.get("requestresponse", None)):
            if not isinstance(issue["requestresponse"], list):
                vuln_poc_request_response = issue["requestresponse"]
                vuln_poc_request = self.get_cleaned_http_data(vuln_poc_request_response["request"]["#text"]) if "request" in vuln_poc_request_response else ""
                vuln_poc_response = self.get_cleaned_http_data(vuln_poc_request_response["response"]["#text"]) if "response" in vuln_poc_request_response else ""
                evidences.append({
                    'req' : vuln_poc_request,
                    'resp' : vuln_poc_response
                })
                index = index + 1
            else:
                vuln_poc_evidences = issue["requestresponse"]
                for vuln_poc_request_response in vuln_poc_evidences:
                    vuln_poc_request = self.get_cleaned_http_data(vuln_poc_request_response["request"]["#text"]) if "request" in vuln_poc_request_response else ""
                    vuln_poc_response = self.get_cleaned_http_data(vuln_poc_request_response["response"]["#text"]) if "response" in vuln_poc_request_response else ""

                    evidences.append({
                        'req' : vuln_poc_request,
                        'resp' : vuln_poc_response
                    })
                    index = index + 1
        return evidences

    def extract_affected_service(self, vuln_ip: str, vuln_baseurl: str, vuln_urlpath: str, vuln_fullurl: str): 
        splitted_baseurl = vuln_baseurl.split(":")
        vuln_service = splitted_baseurl[0] #scheme
        vuln_fqdn = splitted_baseurl[1].split("/")[2]
        vuln_port = ""
        if (len(splitted_baseurl) > 2):
            vuln_port = vuln_baseurl.split(":")[-1]
        elif (vuln_service == "https"):
            vuln_port = "443"
        elif (vuln_service == "http"):
            vuln_port = "80"
        # the host is either a domain or an ip
        # Create affected service
        affected_service  = {
            'host' : vuln_fqdn,
            'port' : vuln_port,
            'protocol' : "tcp"
            # TODO these other parameters may be redundant
            #'ip' : vuln_ip,
            #'service' : vuln_service,
            #'baseurl' : vuln_baseurl,
            #'fqdn' : vuln_fqdn,
            #'urlpath' : vuln_urlpath,
            #'fullurl' : vuln_fullurl
        }
        return affected_service

    # group by vulnerability type (name)
    def aggregate_vulnerabilities(self):
        the_id = 1
        data_to_write = []
        issue_array = self.__report_dict["issues"]["issue"]
        for issue in issue_array:
            vuln_name = issue.get("name","")
            # Exclude vulners issues
            if vuln_name == "[Vulners] Software detected":
                continue
            vuln_ip = issue.get("host","")["@ip"]
            vuln_baseurl = issue.get("host","")["#text"]
            vuln_urlpath = issue.get("path","")
            vuln_fullurl = vuln_baseurl + vuln_urlpath
            # vuln_fqdn = network_utils.extract_fqdn_from_url(vuln_fullurl)
            vuln_severity = issue.get("severity","").capitalize()
            if vuln_severity == "Information":
                vuln_severity = "Info"
            vuln_type_id = issue.get("type","")
            vuln_description = html2plain(issue.get("issueDetail","")) #html
            # vuln_issue = self.__vulnerabilities_information[vuln_type_id][self.__lang]["description"]
            # vuln_remediation = self.__vulnerabilities_information[vuln_type_id][self.__lang]["remediation"]
            # vuln_references = self.__vulnerabilities_information[vuln_type_id][self.__lang]["references"]
            # vuln_classifications = self.__vulnerabilities_information[vuln_type_id][self.__lang]["vulnerability_classifications"]
            # The lists for external and internal addresses are handled separately 
            affected_service = self.extract_affected_service(vuln_ip, vuln_baseurl, vuln_urlpath, vuln_fullurl)
            evidences = self.extract_evidences(issue)
            # print(vuln_fullurl)
            # print(evidences)
            for e in evidences: 
                data_to_write.append({
                    'test_case' : vuln_fullurl,
                    'found': 1,
                    'how' : 'Burp',
                    'class' : vuln_name, 
                    'vulnerable': -1, 
                    'notes' : '',
                    'request' : e['req'],
                    'response' : e['resp']
                })
                # data_to_write.append({
                #     'id' : the_id,
                #     'vuln_name': vuln_name,
                #     'vuln_ip' : vuln_ip,
                #     'vuln_baseurl': vuln_baseurl,
                #     'vuln_urlpath' : vuln_urlpath,
                #     'vuln_fullurl' : vuln_fullurl,
                #     'vuln_serverity' : vuln_severity,
                #     'vuln_type_id' : vuln_type_id,
                #     'vuln_descriptiont' : vuln_description,
                #     'request' : e['req'],
                #     'response' : e['resp']
                # })
                # the_id = the_id + 1
            # vulnerability_to_be_added  = {
            #         'type' : 'req-res',
            #         'discovered_through' : 'burp',
            #         'name' : vuln_name,
            #         'description': vuln_description,
            #         # 'recommendations': vuln_remediation,
            #         'severity': 'severity',
            #         'cves' : [],
            #         # 'references' : vuln_references,
            #         'affected_services' : [affected_service],
            #         'evidences' : evidences
            # }
            # if self.is_aggregated_vulnerability_already_present(vulnerability_to_be_added['name']):
            #     self.append_affected_service(vulnerability_to_be_added['name'], affected_service)
            #     self.append_evidences(vulnerability_to_be_added['name'], evidences)
            # else:
            #     self.add_aggregated_vulnerability(vulnerability_to_be_added)
        return data_to_write

    # Call this method from outside after the constructor
    def parse(self):
        log_info("Starting Burp xml parser...")
        self.__parse_xml_report()
        # self.__read_vulnerability_information()
        data_to_write = self.aggregate_vulnerabilities()
        self.write_data(data_to_write)
        # return self._aggregated_vulnerabilities



if __name__ == "__main__":
    if len(sys.argv) != 3:
        usage()

    burp_results_file = sys.argv[1]
    har_session_where_take_entries = sys.argv[2]


    bxml = BurpXMLParser(burp_results_file, har_session_where_take_entries)
    bxml.parse()