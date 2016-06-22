/etc/vconsole.conf:
  file.managed:
    - source: salt://files/vconsole.conf
    - user: root
    - group: root
    - mode: 644

loadkeys fr:
  cmd.run