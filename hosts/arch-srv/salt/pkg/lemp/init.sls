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

set-mysql-root-password:
  cmd.run:
  - name: 'echo "update user set password=PASSWORD(''{{salt['pillar.get']('mariadb_root_pw')}}'') where User=''root'';flush privileges;" | /usr/bin/env HOME=/ mysql -uroot mysql'
  - onlyif: '/usr/bin/env HOME=/ mysql -u root'
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

msmtp:
  pkg.latest

msmtp-mta:
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