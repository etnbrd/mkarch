grunt-cli:
  npm:
    - installed
  require:
    - pkg: nodejs

ghost:
  git.latest:
    - name: https://github.com/TryGhost/Ghost.git
    - target: /srv/http/ghost
    - submodules: true
    - rev: master
  cmd.wait:
    - name: npm install
    - cwd: /srv/http/ghost
    - watch:
      - git: ghost
  cmd.wait:
    - name: grunt
    - cwd: /srv/http/ghost
    - watch:
      - git: ghost
    - require:
      - cmd: npm install
  require:
    - pkg: nodejs
    - npm: grunt-cli