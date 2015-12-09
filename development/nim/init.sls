# Directory to check out and build Nim in
{% set nim_dir = salt["pillar.get"]("nim_dir", "/usr/local/nim") %}
{% set nim_overwrite_existing = salt["pillar.get"]("nim_overwrite_existing", False) %}

# Example for building Nim at a specific revision
{% set nim_git_rev = salt["pillar.get"]("nim_git_rev", "HEAD") %}
{% set nim_git_branch = salt["pillar.get"]("nim_git_branch", "devel") %}

# (The C sources should not typically need to be changed)
{% set csources_git_rev = salt["pillar.get"]("csources_git_rev", "HEAD") %}
{% set csources_git_branch = salt["pillar.get"]("csources_git_branch", "devel") %}

git:
  pkg.installed

https://github.com/nim-lang/Nim.git:
  git.latest:
    - rev: {{ nim_git_rev }}
    - branch: {{ nim_git_branch }}
    - force_clone: {{ nim_overwrite_existing }}
    - force_reset: true
    - target: {{ nim_dir }}
    - require:
      - pkg: git

https://github.com/nim-lang/csources:
  git.latest:
    - rev: {{ csources_git_rev }}
    - branch: {{ csources_git_branch }}
    - force_clone: {{ nim_overwrite_existing }}
    - force_reset: true
    - target: {{ nim_dir }}/csources
    - depth: 1
    - watch:
      - git: "https://github.com/nim-lang/Nim.git"

build_nim_csources:
  cmd.wait:
    - name: sh build.sh
    - cwd: {{ nim_dir }}/csources
    - watch: 
      - git: "https://github.com/nim-lang/csources"

build_nim_koch:
  cmd.wait:
    - name: bin/nim c koch
    - cwd: {{ nim_dir }}
    - watch: 
      - git: "https://github.com/nim-lang/Nim.git"

build_nim:
  cmd.wait:
    - name: ./koch boot -d:release
    - cwd: {{ nim_dir }}
    - watch: 
      - git: "https://github.com/nim-lang/Nim.git"

{{ nim_dir }}/bin/nim:
  file.managed:
    - mode: 755
    - create: false
    - replace: false

nim_mingw:
  file.append:
    - name: {{ nim_dir }}/config/nim.cfg
    - source: salt://development/nim/mingw.nim.cfg

