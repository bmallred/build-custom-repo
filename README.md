build-custom-repo
=================

Build custom repository of Arch AUR packages for use with the live CD

choosing your packages
----------------------

You must specifically name each of the AUR packages you wish to include in
the repository inside of the `packages.list` file. The format is meant to
be simple and human readable so just one package name per line.

building the repository
-----------------------

Execute the script `build.sh` to clean the previous contents and build the
packages. The dependency on `wget` and `makepkg` are present and it is assumed
it is being ran on a 64-bit system.
