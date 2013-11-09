nginx:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

mysql-python:
  pkg.latest

mariadb:
  pkg:
    - latest
  service.running:
    - name: mysqld
    - enable: True
    - reload: True
  mysql_user:
    - present
    - name: root
    - password_hash: '*639C3D4E2A19BCE8C48D40326378DC7039F43D90'
    - require:
      - service: mariadb
      - pkg: mysql-python

php-fpm:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

php-gd:
  pkg.latest

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://pkg/lemp/nginx.conf
    - user: root
    - group: root
    - mode: 644

/etc/php/php.ini:
  file.managed:
    - source: salt://pkg/lemp/php.ini
    - user: root
    - group: root
    - mode: 644