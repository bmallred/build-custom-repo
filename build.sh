#!/bin/zsh

# Pull the packages in from a more human readable file
packages=("${(@f)$(cat packages.list)}")

# Clean everything up
if [[ -d ./packages ]]; then
    if [[ -e ./packages/* ]]; then
        rm -rf ./packages/*
    fi
else
    mkdir ./packages
fi

if [[ -d ./x86_64 ]]; then
    if [[ -e ./x86_64/* ]]; then
        rm -rf ./x86_64/*
    fi
else
    mkdir ./x86_64
fi

if [[ -d ./i686 ]]; then
    if [[ -e ./i686/* ]]; then
        rm -rf ./i686/*
    fi
else
    mkdir ./i686
fi

# Move to our working directory
cd packages

for p in $packages;
do
    # Grab the most recent packages
    wget https://aur.archlinux.org/packages/$p[0,2]/$p/$p.tar.gz
    
    # Unpackage the compressed packages
    tar -xvf $p.tar.gz
    
    # Make the Arch packages
    cd $p
    makepkg --config ../../makepkg64.conf && mv *.pkg.tar.xz ../../x86_64
    linux32 makepkg --config ../../makepkg32.conf && mv *.pkg.tar.xz ../../i686
    cd ..
done


# Add the Arch packages to the repositories
cd ..
if [[ -e ./x86_64/*.tar.xz ]]; then
    repo-add -n ./x86_64/customrepo.db.tar.gz ./x86_64/*.tar.xz
fi

if [[ -e ./i686/*.tar.xz ]]; then
    repo-add -n ./i686/customrepo.db.tar.gz ./i686/*.tar.xz
fi
