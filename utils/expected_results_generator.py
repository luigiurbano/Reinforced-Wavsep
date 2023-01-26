import csv
import os
import sys
from har_manager import print_from_har, send_from_har, urls_from_har
import urllib.parse
from my_har_parser import get_har_file, get_categories, get_har_sessions

header = ['# test name', 'category', 'real vulnerability', 'cwe','Benchmark version: 1.8','date']
RESULT_NAME = "expected_results_reinforced_wavsep-1.8.csv"



class OwaspReinforcedMap:
    """
    The following class maps the CWE, owasp categories and reinforced wavsep 
    OWASP and CWE: 
        cmdi,78
        crypto,327
        hash,328
        ldapi,90
        pathtraver,22
        securecookie,614
        sqli,89
        trustbound,501
        weakrand,330
        xpathi,643
        xss,79

    REINFORCED: 
        lfi
        open-redirect
        os
        rfi
        sql
        xss
        xxe 
    """

    def __init__(self, owasp_cat, reinforced_cat, cwe):
        self.owasp_cat = owasp_cat
        self.reinforced_cat = reinforced_cat
        self.cwe = cwe 



mappings = [
    OwaspReinforcedMap('cmdi', 'os', '78'),
    OwaspReinforcedMap('cmdi', 'os', '78'),
    OwaspReinforcedMap('pathtraver', 'lfi', '22'),
    OwaspReinforcedMap('pathtraver', 'rfi', '22'),
    OwaspReinforcedMap('redirect', 'open-redirect', '601'),
    OwaspReinforcedMap('xss', 'xss', '79'),
    OwaspReinforcedMap('xpathi', 'xxe', '643'),
    OwaspReinforcedMap('sqli', 'sql', '89'),
]

def find_map(reinforced_cat: str): 
    global mappings
    for m in mappings: 
        if m.reinforced_cat == reinforced_cat:
            return m



def write_csv(rows):
    with open(RESULT_NAME, 'w', newline =  '') as csvfile: 
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(header)
        csvwriter.writerows(rows)



def false_positive_convert(string):
    # remove the suffix
    string = string.split("-")[0]
    # convert to lowercase
    string = string.lower()
    # remove non-alphabetic characters
    # Output: ['lfi', 'sinjection', 'rfi', 'redirect', 'rxss']
    string = ''.join(e for e in string if e.isalnum())
    if string == 'sinjection': 
        string = 'sql'
    if string == 'redirect':
        string = 'open-redirect'
    if string == 'rxss':
        string = 'xss'

    return string



def e():
    sys.exit(-1)

def p(a):
    print("[+] {}".format(a))


def extract_testname(url):
    parsed_url = urllib.parse.urlparse(url)
    path = parsed_url.path
    file_name = path.split("/")[-1]
    return os.path.splitext(file_name)[0]



p("Get har sessions")
rows = []



def get_urls(category, sessions):
    urls = []
    for s in sessions: 
        filepath = get_har_file(category, s)
        urls = urls + urls_from_har(filepath)
    return urls



har_sessions = get_har_sessions()

for category, sessions in har_sessions.items():
    if category != 'false-positives':
        m = find_map(category)
        urls = get_urls(category, sessions)
        for u in urls:
            testname = extract_testname(u)
            """ 
            # test name, category, real vulnerability, cwe, Benchmark version: 1.2, 2016-06-1
                BenchmarkTest00001,pathtraver,true,22
                BenchmarkTest00002,pathtraver,true,22

            """
            if testname.startswith('Case'):
                rows.append([testname, m.owasp_cat, 'true', m.cwe])

    else:
        for s in sessions: 
            filepath = get_har_file(category, s)
            real_category = false_positive_convert(s)
            m = find_map(real_category)
            urls = urls_from_har(filepath)
            # urls = get_urls(category, sessions)
            for u in urls: 
                testname = extract_testname(u)
                if testname.startswith('Case'):
                    rows.append([testname, m.owasp_cat, 'false', m.cwe])

write_csv(rows)
p("File written to {}".format(RESULT_NAME))