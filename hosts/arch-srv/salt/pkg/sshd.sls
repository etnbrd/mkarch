openssh:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True