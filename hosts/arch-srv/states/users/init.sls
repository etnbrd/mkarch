include:
  - etn
  - known_hosts

/etc/sudoers:
  file.managed:
    - source: /srv/salt/config/sudoers