grunt-cli:
  npm:
    - installed
  require:
    - pkg: nodejs

sass:
  cmd.run:
    - name: gem install --no-user-install sass
  require:
    - pkg: ruby

ghost:
  git.latest:
    - name: https://github.com/TryGhost/Ghost.git
    - target: /srv/http/ghost
    - submodules: true
    - rev: master
  cmd.run:
    - name: 'npm install && grunt init && grunt'
    - cwd: /srv/http/ghost
    - watch:
      - git: ghost
  require:
    - pkg: nodejs
    - npm: grunt-cli
    - cmd: sass