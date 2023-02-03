from copy import deepcopy
import json
import sys

import requests
from urllib.parse import urlparse

# from haralyzer import HarParser, HarPage
from my_har_parser import HarParser

DEFAULT_TIMEOUT = 2


methods = {
    "GET": requests.get,
    "POST": requests.post,
    "PUT": requests.put,
    "DELETE": requests.delete
}

def default_headers():
    return {"User-Agent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:69.0) Gecko/20100101 Firefox/69.0"}

class HttpRequest:
    def __init__(self, url: str, method: str = "GET", path: str = "/", headers={}, params={}, proxy=""):
        self.url = url
        self.method = method
        self.path = path
        # HttpHeader
        self.headers = {**deepcopy(headers), **default_headers()}
        # If method is post, define the GET
        self.params = deepcopy(params)
        self.proxy = proxy

    def set_proxy(self, host, port):
        self.proxy = "http://{}:{}".format(host, port)


    @staticmethod
    def get(url, path="/", headers={}, params={}):
        return HttpRequest(url, "GET", path, headers, params)

    @staticmethod
    def post(url, path="/", headers={}, params={}):
        return HttpRequest(url, "POST", path, headers, params)

    @staticmethod
    def put(url, path="/", headers={}, params={}):
        return HttpRequest(url, "PUT", path, headers, params)

    @staticmethod
    def delete(url, path="/", headers={}, params={}):
        return HttpRequest(url, "DELETE", path, headers, params)

    def send(self):
        req_function = methods[self.method]
        if self.method == "POST":
            resp = req_function(self.url + self.path, proxies = {"http" : self.proxy, "https" : self.proxy}, verify = False, data = self.params, headers = self.headers)
        else:
            resp = req_function(self.url + self.path, proxies = {"http" : self.proxy, "https" : self.proxy}, verify = False, params = self.params, headers = self.headers)
        return resp


    def add_header(self, name, value):
        if (self.contains_header(name)):
            raise Exception("Duplicate Param")
        self.headers[name] = value
        return self

    def add_param(self, name, value, in_query_string):
        # TBD = same param in query and in body
        self.params[name] = value
        return self


    def to_dict(self):
        return {
            "url": self.url,
            "method": self.method,
            "path": self.path,
            "headers": self.headers,
            "params" : self.params
        }

    def to_json(self):
        return json.dumps(self.to_dict(), indent=4)

    def __str__(self):
      return str(self.to_dict())
        # return """POST {}\nHost: {}\n{}\n{}""".format(self.path, urlparse(self.url).netloc, self.headers_to_str(), self.params_to_str())


json_obj = []

def to_dict(l: list):
    """Generate a dictionary from an array

    Args:
        l (list): A list

    Returns:
        dict: A dictionary
    """
    ret = {}
    for i in l:
        ret[i['name']] = i['value']
    return ret

def send_request(req, proxy):
    req_function = methods[req.method]
    the_url = urlparse(req.url).scheme
    try:
        if the_url != 'http' and the_url != 'https':
            print("[-] Invalid scheme protocol: {}".format(the_url))
        else:
            if req.method == "POST":
                resp = requests.post(req.url , proxies = {"http" : proxy, "https" : proxy}, verify = False, data = req.body, headers = req.headers, allow_redirects=False, timeout=DEFAULT_TIMEOUT)
            else:
                resp = req_function(req.url, proxies = {"http" : proxy, "https" : proxy}, verify = False, headers = req.headers, allow_redirects= False, timeout=DEFAULT_TIMEOUT)
            return resp
    except requests.exceptions.ReadTimeout:
        print(req.url)
        print("[-] Req exception timeout")


def send_from_har(har_file, proxy):
    requests = HarParser.from_file(har_file)
    for r in requests:
        # print("Send {}".format(r.url))
        send_request(r, proxy)


def print_from_har(har_file):
    requests = HarParser.from_file(har_file)
    for r in requests:
        print(r.url)

def urls_from_har(har_file):
    requests = HarParser.from_file(har_file)
    return [r.url for r in requests]
