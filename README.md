# salt-nim
Salt formulas for installing/building Nim

## Basic Usage

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

## Advanced Usage

The formula will look at pillar data for the following items. 

 * nim_dir : The directory used to check out Nim and build it in. Defaults to /usr/local/nim
 * nim_overwrite_existing : Boolean for whether to require a non-existent directory for nim_dir. Defaults as True. Take care with this option as any existing content in nim_dir gets wiped out. 
 * nim_git_rev : Revision to check out and build. Defaults to HEAD
 * nim_git_branch : Branch to check out and build. Defaults to devel
 
You can also set the revision and branch for the C sources for bootstrapping Nim, but it is not that common to change these. These do not need to be the same values as the revision and branch as what you build Nim with. 

 * csources_git_rev : Revision to check out and build. Defaults to HEAD
 * csources_git_branch : Branch to check out and build. Defaults to devel

## TODO 

 * Add notes about how to get a basic Salt installation going for those that don't have that already
 * Add a formula for building nimble

