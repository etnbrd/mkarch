openssh:
  pkg:
    - latest
  service.running:
    - name: sshd
    - enable: True
    - reload: True