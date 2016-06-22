/etc/locale.gen:
  file.managed:
    - source: salt://files/locale.gen
    - user: root
    - group: root
    - mode: 644

# export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8:
  cmd.run