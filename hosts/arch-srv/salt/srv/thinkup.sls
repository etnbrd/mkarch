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