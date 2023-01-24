import os
import sys

import argparse


from har_manager import print_from_har, send_from_har, urls_from_har
from my_har_parser import get_har_file, get_categories,get_har_sessions

parser = argparse.ArgumentParser(description='Run crawler')
parser.add_argument('category', nargs='?', default="")
parser.add_argument('harfile', nargs='?', default="")

args = parser.parse_args()

def e():
    sys.exit(-1)

def usage():
    print("[-] Usage: print_requests.py <category> <har_file> ")
    e()

har_sessions = {}
if args.category == "": 
    har_sessions = get_har_sessions()

elif args.harfile == '': 
    har_sessions = get_har_sessions(args.category)

else: 
    har_sessions[args.category] = [args.harfile]


for category, sessions in har_sessions.items():
    for s in sessions:
        filepath = get_har_file(category, s)
        print_from_har(filepath)