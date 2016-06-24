docker:
  - pkg.latest

docker:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: docker