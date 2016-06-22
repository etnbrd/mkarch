base:
  '*':
    - users
    - pkg.sshd
    - nodejs:
      pkg:
        - latest
    - Europe/Paris:
      timezone.system:
        - utc: True