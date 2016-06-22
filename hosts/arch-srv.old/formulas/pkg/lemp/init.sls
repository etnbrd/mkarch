###################################
# Nginx                           #
###################################

nginx:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://pkg/lemp/nginx.conf
    - user: root
    - group: root
    - mode: 644


###################################
# MariaDB                         #
###################################

mariadb:
  pkg:
    - latest
  service.running:
    - name: mysqld
    - enable: True
    - reload: True

mysql-python:
  pkg.latest

set-mysql-root-password:
  cmd.run:
  - name: 'echo "update user set password=PASSWORD(''{{salt['pillar.get']('mariadb_root_pw')}}'') where User=''root'';flush privileges;" | /usr/bin/env HOME=/ mysql -uroot mysql'
  - onlyif: '/usr/bin/env HOME=/ mysql -u root'
  - require:
    - service: mariadb


###################################
# PHP                             #
###################################

php-fpm:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

php-gd:
  pkg.latest


/etc/php/php.ini:
  file.managed:
    - source: salt://pkg/lemp/php.ini
    - user: root
    - group: root
    - mode: 644


###################################
# Postfix                         #
###################################

postfix:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True

/etc/postfix/main.cf:
  file.managed:
    - source: salt://pkg/lemp/main.cf
    - user: root
    - group: root
    - mode: 644