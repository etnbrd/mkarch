thinkup:
  git.latest:
    - name: http://github.com/ginatrapani/ThinkUp
    - target: /usr/share/lib/thinkup
    - rev: master
  cmd.wait:
    - name: ln -s /usr/share/lib/thinkup/webapp /srv/http/thinkup
    - watch:
      - git: thinkup