{% for pkg in [
'zsh',
'git',
'rsync'
] %}
{{ pkg }}:
  pkg.latest
{% endfor %}