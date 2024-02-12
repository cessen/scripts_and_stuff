# NixOS Helpers

A set of utilities to make living in NixOS a little easier.  NixOS is really big on environment purity, which is great.  But sometimes you just want to get things done.  These utilities help do things like run downloaded executables and easily work on development projects without having to jump through hoops first.

* `nsh.py` - A wrapper for nix-shell that also searches parent directories for `shell.nix` etc.  This is to allow e.g. having a general default.nix in your home directory for common development.  This can be especially handy when working on other people's projects that may not want a `shell.nix` etc. in their repo.
* `fhs_run.sh` - Runs a command in a constructed FHS environment with various packages installed.  This is to help run downloaded software, the vast majority of which expects an FHS system layout.  The intent is for this to be updated with more and more packages over time, to make an easy-to-use executable runner.
* `nix_find_libs.sh` - Finds what Nix packages you need for running a given executable.  If an executable won't run with `fhs_run.sh`, this can help figure out what packages need to be added to `fhs_run.sh` to run it.  Not a 100% solution, however.

`fhs_run.sh` and `nix_find_libs.sh` are both based on tools in [nix-autobahn](https://github.com/Lassulus/nix-autobahn) (the latter in particular being essentially a straight copy).  The latter also requires `find`, `fzf`, and `nix-index` to be installed and in your executable path.
