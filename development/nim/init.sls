git:
  pkg.installed

https://github.com/Araq/Nim.git:
  git.latest:
    - rev: devel
    - target: /usr/local/nim
    - require:
      - pkg: git
    - unless:
      - ls /usr/local/nim/bin/nim

https://github.com/nim-lang/csources:
  git.latest:
    - rev: devel
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
      - git: "https://github.com/Araq/Nim.git"

build_nim:
  cmd.wait:
    - name: ./koch boot -d:release
    - cwd: /usr/local/nim
    - watch: 
      - git: "https://github.com/Araq/Nim.git"

nim_mingw:
  file.append:
    - name: /usr/local/nim/config/nim.cfg
    - source: salt://development/nim/mingw.nim.cfg

