openssh:
  pkg:
    - latest
  service.running:
    - name: sshd
    - enable: True
    - reload: True

/etc/ssh/sshd_config:
  file.managed:
    - source: /srv/salt/config/sshd_config
    - user: root
    - group: root
    - mode: 700
    - require.pkg: openssh