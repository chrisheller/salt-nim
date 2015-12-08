# Example for building Nim at a specific revision
# {% set nim_git_rev = '6818304e011b4376820401fbe37b25c973167ac9' %}
{% set nim_git_rev = 'devel' %}

# (The C sources should typically be 'devel' though)
{% set csources_git_rev = 'devel' %}

git:
  pkg.installed

https://github.com/nim-lang/Nim.git:
  git.latest:
    - rev: {{ nim_git_rev }}
    - target: /usr/local/nim
    - require:
      - pkg: git
    - unless:
      - ls /usr/local/nim/bin/nim

https://github.com/nim-lang/csources:
  git.latest:
    - rev: {{ csources_git_rev }}
    - target: /usr/local/nim/csources
    - depth: 1
    - unless:
      - ls /usr/local/nim/csources

build_nim_csources:
  cmd.wait:
    - name: sh build.sh
    - cwd: /usr/local/nim/csources
    - watch: 
      - git: "https://github.com/nim-lang/csources"

build_nim_koch:
  cmd.wait:
    - name: bin/nim c koch
    - cwd: /usr/local/nim
    - watch: 
      - git: "https://github.com/nim-lang/Nim.git"

build_nim:
  cmd.wait:
    - name: ./koch boot -d:release
    - cwd: /usr/local/nim
    - watch: 
      - git: "https://github.com/nim-lang/Nim.git"

/usr/local/nim/bin/nim:
  file.managed:
    - mode: 755
    - create: false
    - replace: false

nim_mingw:
  file.append:
    - name: /usr/local/nim/config/nim.cfg
    - source: salt://development/nim/mingw.nim.cfg

