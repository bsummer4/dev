# Makefiles are terrible for this kind of thing, but everybody uses them
# for this, so I'll just follow the convention.

PKGNAME=bendev

.PHONY: install-nix install build enter

usage:
	@echo Run one of these:
	@echo '    ' make install-nix '|' install '|' build '|' enter

install-nix:
	curl https://nixos.org/nix/install | sh

install:
	nix-env -f default.nix -i ${PKGNAME}

build:
	nix-build

enter:
	nix-shell --pure
