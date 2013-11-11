grunt:
  npm:
    - installed
  require:
    - pkg: nodejs

# ghost:
#   git.latest:
#     - name: https://github.com/TryGhost/Ghost.git
#     - target: /srv/http/ghost
#     - submodules: true
#     - rev: master
#   cmd.wait:
#     - name: npm install --production; grunt;
#     - cwd: /srv/http/ghost
#     - watch:
#       - git: thinkup
#   require:
#     - npm: grunt-cli