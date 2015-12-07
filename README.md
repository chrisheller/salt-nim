# salt-nim
Salt formulas for installing/building Nim

## Running

```sh
git clone https://github.com/chrisheller/salt-nim.git
cd salt-nim
sudo salt-call --file-root . --local state.sls development.nim
```

This should give you a working installation of Nim in /usr/local/nim. 
You can verify this by running:

```sh
/usr/local/nim/bin/nim -v
```

## TODO 

Don't assume that someone wants to install into /usr/local/nim

Add notes about how to get a basic Salt installation going for those that don't have that already

