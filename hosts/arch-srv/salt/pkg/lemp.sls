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
    - enable: True
    - reload: True

php-fpm:
  pkg:
    - latest
  service.running:
    - enable: True
    - reload: True