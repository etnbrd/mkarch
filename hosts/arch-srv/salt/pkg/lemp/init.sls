nginx:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

mariadb:
  pkg:
    - latest
  service.running:
    - name: mysqld
    - enable: True
    - reload: True

php-fpm:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

/etc/nginx/nginx.conf:
  file.managed:
    - source: https://raw.github.com/gravitezero/mkarch/master/hosts/arch-srv/salt/pkg/lemp/nginx.conf
    - user: root
    - group: root
    - mode: 644