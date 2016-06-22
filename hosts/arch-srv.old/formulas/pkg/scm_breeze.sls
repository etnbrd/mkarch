.scm_breeze:
  git.latest:
    - name: http://github.com/ndbroadbent/scm_breeze.git
    - target: /home/etn/.scm_breeze
    - rev: master
  require:
    - user: etn
    - pkg: git
    - pkg: zsh