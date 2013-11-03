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
  mysql_user:
    - present
    - name: root
    - password: {{ salt['pillar.get']('mariadb_root_pw') }}
    - require:
      - service: mariadb

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