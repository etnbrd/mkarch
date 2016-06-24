docker:
  - pkg.latest
  - service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: docker