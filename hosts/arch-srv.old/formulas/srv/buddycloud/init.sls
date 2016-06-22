# TODO add iptables
# inbound web, server to server and outbound server to server
# iptables -A INPUT  -m state --state NEW -s 0.0.0.0/0 -d 193.183.99.131 -p tcp --dport 80   -j ACCEPT 
# iptables -A INPUT  -m state --state NEW -s 0.0.0.0/0 -d 193.183.99.131 -p tcp --dport 443  -j ACCEPT 
# iptables -A INPUT  -m state --state NEW -s 0.0.0.0/0 -d 193.183.99.131 -p tcp --dport 5269 -j ACCEPT
# iptables -A OUTPUT -m state --state NEW -s 193.183.99.131 -d 0.0.0.0/0 -p tcp --dport 5269 -j ACCEPT

prosody:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

/etc/prosody/prosody.cfg.lua:
  file.managed:
    - source: salt://srv/buddycloud/prosody.cfg.lua
    - user: root
    - group: root
    - mode: 644

# buddycloud:
#   iptables.append:
#     - table: filter
#     - chain: INPUT
#     - match: state
#     - connstate: NEW
#     - dport: 80
#     - proto: tcp
#     - sport: 80
#     - save: True
#     - jump: ACCEPT