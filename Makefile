# Core implementation of the dotfiles management logic.
# 
# Run `make` for a list of targets. See README.md for more details.

.NOTPARALLEL:

# https://stackoverflow.com/a/35698978/318964
THISDIR := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))

# List of dotfile modules installed
PACKAGES := $(shell ls -1d $(THISDIR)/*/ | awk -F/ '{print $$(NF-1)}')

# A "do nothing", list options default target
# https://stackoverflow.com/a/45843594/318964
.PHONY: help
help:
	@echo "Possible actions:"
	@grep --color=always -h '^.PHONY: .*.# ' Makefile | sed 's/\.PHONY: \(.*\).# \(.*\)/\1\t\2/' | expand -t30

.PHONY: list  # List installed dotfiles packages printing the first line of their README.
list:
	@for f in $(PACKAGES); do echo $$f: `head -n1 $$f/README.md`; done;

.PHONY: install  # Install dotfiles and run .install.d/ postinstall scripts.
install: stow
	bash -c 'for f in ~/.install.d/*; do source "$$f"; done'

.PHONY: stow  # Install ("restow") dotfiles.
# NB: --dotfiles would be a convenient option, but https://github.com/aspiers/stow/issues/33
stow:
	stow --ignore='^README.md' -t ~ -d $(THISDIR) --restow $(PACKAGES)

