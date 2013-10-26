sshd:
  name: openssh
  pkg:
    - latest
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: sshd