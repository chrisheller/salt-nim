# Directory to install Nimble into. 
{% set nimble_dir = salt["pillar.get"]("nimble_dir", "/usr/local/nim/nimble") %}
{% set nimble_overwrite_existing = salt["pillar.get"]("nimble_overwrite_existing", False) %}

# Example for building Nimble at a specific revision
{% set nimble_git_rev = salt["pillar.get"]("nimble_git_rev", "HEAD") %}
{% set nimble_git_branch = salt["pillar.get"]("nimble_git_branch", "devel") %}

git:
  pkg.installed

https://github.com/nim-lang/nimble.git:
  git.latest:
    - rev: {{ nimble_git_rev }}
    - branch: {{ nimble_git_branch }}
    - force_clone: {{ nimble_overwrite_existing }}
    - force_reset: true
    - target: {{ nimble_dir }}
    - require:
      - pkg: git

build_nim_koch:
  cmd.wait:
    - name: ../bin/nim c -r src/nimble install
    - cwd: {{ nimble_dir }}
    - watch: 
      - git: "https://github.com/nim-lang/nimble.git"

