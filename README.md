# Reproducable Development Environment

When I switch computers, it takes an annoying long time to get my
development environment setup exactly as I like it. A `dotfiles`
repo helps with that, but

  - It doesn't automatically setup and install all the tools that I need
    on any linux/mac computer.
  - It doesn't force me to keep my configuration updated. There are usually
    small, local changes that I forget to push back into my dotfiles repo.

So, I want a solution that has the following properties:

  - Works on on every Linux distribution, and also on OSX.
  - Is fast enough that I can "check out" a new copy of my development
    environment for every programming session.

I've tried a ton of different approaches in the past: custom linux live
cds, shell scripts that reformat my entire home directory, using aufs union
files system as my home directory to make direct changes to configuration
files temporary, developing from inside of a Docker container. All of
these approaches ended up being a huge hassle. I'm hoping that I nix will
solve all of my problems.

## Usage

To install the Nix package manager:

    make install-nix


To install dev tools including scripts to setup a new home directory:

    make install


To run test build:

    make build


To enter a virtual enironment with only these tools available:

    make enter
