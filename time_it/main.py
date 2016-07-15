import argparse
import re
import sys
import datetime
import subprocess
import time

parser = argparse.ArgumentParser(description='execute comand after certain time')
parser.add_argument('command',help='command to be executed')
parser.add_argument('time', nargs="+", help='time - valid formats are:12:23:10, 12:30, 12h, 45min, 12h45min')
args = parser.parse_args()
args.time = ''.join(args.time)
f1=re.match("(\d\d?)(h)? ?(\d\d?)?(min)?",args.time)
f2=re.match("(\d\d?):(\d\d?):?(\d?\d?)",args.time)

if f2:
    h=int(f2.group(1))
    min=int(f2.group(2))
    if f2.group(3)!='':
        sec=int(f2.group(3))
    else:
        sec=0
    time_then=datetime.datetime(datetime.datetime.now().year, datetime.datetime.now().month, datetime.datetime.now().day, hour=h, minute=min, second=sec)
    if time_then<datetime.datetime.now():
        time_then+=datetime.timedelta(1)
elif f1:
    if f1.group(2)!=None and f1.group(4)!=None:
        h=int(f1.group(1))
        min=int(f1.group(3))
    elif f1.group(2)==None and f1.group(4)!=None:
        h=0
        min=int(f1.group(1))
    else:
        h=int(f1.group(1))
        min=0
    time_then = datetime.timedelta(hours=h,minutes=min)+datetime.datetime.now()
else:
    parser.print_help()
    sys.exit(1)

time_now = datetime.datetime.now()
time_delta=time_then-time_now
time.sleep(time_delta.seconds)
print subprocess.check_output(args.command.split())
