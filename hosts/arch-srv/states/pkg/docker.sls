docker package:
  - pkg.latest:
    - name: docker

docker service:
  service.running:
    - name: docker
    - enable: True
    - reload: True
    - watch:
      - pkg: docker