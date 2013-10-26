nginx:
  pkg:
    - latest
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: nginx

mariadb:
  pkg:
    - latest
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: mariadb

php-fpm:
  pkg:
    - latest
  service:
    - running
    - enable: True
    - reload: True
    - watch:
      - pkg: php-fpm