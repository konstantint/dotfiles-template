# Simple dotfiles management system

## Setting up your dotfiles

1. Install `git`, `make` and `stow`.

       sudo apt -y install make git stow

2. Copy this template to your own `dotfiles` repository (click
   *"Use this template"* button), then clone it to your `$HOME` directory:

       cd; git clone https://github.com/$USER/dotfiles

3. Develop and include your "dotfiles modules" as needed, e.g.:

       git submodule add https://github.com/konstantint/dotfiles-ubuntu
       git commit -am "Added dotfiles packages"
       ... don't forget to edit README.md ...
       git push

## Usage

Deploy the dotfiles by running `make install` in this directory.
This will perform the following:

- Run `stow --dotfiles --restow -t ~ $PACKAGES` where $PACKAGES are all
  subdirectories of this directory.
- Run all scripts in `~/.install.d`. This makes it possible for modules to
  contain "postinstall" logic besides just the files (e.g. the modules may
  actually do `apt install` of the needed system packages, change file
  permissions, etc).

Note that if you have conflicting files in your home directory,
operations will be aborted with error messages, clean those files manually
and rerun `make install` until it succeeds.

Ignore the `BUG in find_stowed_paths` [warning](https://github.com/aspiers/stow/issues/65).

The makefile offers a few extra utilities, run `make` to list them.

It can be helpful to have a shorthand command for pulling updates, redeploying
the dotfiles and refreshing the environment, such as [the
following](https://github.com/konstantint/dotfiles-ubuntu/blob/main/.bashrc.d/update_dotfiles.sh).

