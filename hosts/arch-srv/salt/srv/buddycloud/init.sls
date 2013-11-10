
# inbound web, server to server and outbound server to server
# iptables -A INPUT  -m state --state NEW -s 0.0.0.0/0 -d <your server address> -p tcp --dport 80   -j ACCEPT 
# iptables -A INPUT  -m state --state NEW -s 0.0.0.0/0 -d <your server address> -p tcp --dport 443  -j ACCEPT 
# iptables -A INPUT  -m state --state NEW -s 0.0.0.0/0 -d <your server address> -p tcp --dport 5269 -j ACCEPT
# iptables -A OUTPUT -m state --state NEW -s <your server address> -d 0.0.0.0/0 -p tcp --dport 5269 -j ACCEPT

buddycloud:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: NEW
    - dport: 80
    - proto: tcp
    - sport: 80
    - save: True
    - jump: ACCEPT