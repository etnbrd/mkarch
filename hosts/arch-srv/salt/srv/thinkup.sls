thinkup:
  git.latest:
    - name: http://github.com/ginatrapani/ThinkUp
    - target: /usr/share
    - rev: master
  cmd.wait:
    - name: ln -s /usr/share/thinkup/webapp /srv/http/thinkup
    - watch:
      - git: thinkup