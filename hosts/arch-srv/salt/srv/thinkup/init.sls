thinkup:
  git.latest:
    - name: http://github.com/ginatrapani/ThinkUp
    - target: /usr/share/lib/thinkup
    - rev: master
  cmd.wait:
    - name: rsync -av /usr/share/lib/thinkup/webapp/ /srv/http/thinkup; chown -R http /srv/http/thinkup; chmod -R 777 /srv/http/thinkup/data/
    - watch:
      - git: thinkup
  require:
    - pkg: php-gd
    - pkg: mari
  mysql_user.present:
    - host: localhost
    - password: {{ salt['pillar.get']('mariadb_user_pw') }}
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mariadb_root_pw') }}
  mysql_database.present:
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mariadb_root_pw') }}
  mysql_grants.present:
    - grant: all privileges
    - database: thinkup.*
    - user: thinkup
    - host: localhost
    - connection_user: root
    - connection_pass: {{ salt['pillar.get']('mariadb_root_pw') }}