zsh:
  pkg.latest

.oh-my-zsh:
  git.latest:
    - name: http://github.com/robbyrussell/oh-my-zsh.git
    - target: /home/etn/.oh-my-zsh
    - rev: master
  require:
    - user: etn
    - pkg: git
    - pkg: zsh

/home/etn/.zshrc:
  file.managed:
    - source: salt://dotfiles/.zshrc
    - user: etn
    - group: etn
    - mode: 644

/home/etn/.oh-my-zsh/themes/etn.zsh-theme:
  file.managed:
    - source: salt://dotfiles/etn.zsh-theme
    - user: etn
    - group: etn
    - mode: 644
  require:
    - git: oh-my-zsh