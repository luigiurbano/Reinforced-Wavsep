import os
import sys

import argparse


from har_sender import send_from_har
from my_har_parser import get_har_file, get_categories,get_har_sessions


parser = argparse.ArgumentParser(description='Run crawler')
parser.add_argument('host', nargs='?', default="")
parser.add_argument('port', nargs='?', default="")
parser.add_argument('category', nargs='?', default="")
parser.add_argument('harfile', nargs='?', default="")

args = parser.parse_args()




def e():
    sys.exit(-1)

def usage():
    print("[-] Usage: run_crawler.py <category> <har_file> <host> <port>")
    e()

har_sessions = {}
if args.category == None: 
    har_sessions = get_har_sessions()

elif args.harfile == '': 
    har_sessions = get_har_sessions(args.category)

else: 
    har_sessions[args.category] = [args.harfile]


for category, sessions in har_sessions.items():
    for s in sessions:
        filepath = get_har_file(category, s)
        print(filepath)
        print("[+] Scanning {} har file ".format(filepath))
        send_from_har(filepath, "http://{}:{}".format(args.host, args.port) if args.host else None)
