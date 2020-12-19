#!/usr/bin/make -f

# Copyright (c) 2017 Franco Masotti.
# See LICENSE file for details.

PORT = 3050
default: install-dev

install-dev:
	pipenv install --dev
	pipenv run pre-commit install

uninstall-dev:
	pipenv --rm

all: clean build serve-global

build:
	@jekyll build --trace --strict_front_matter --verbose --safe -t --future

serve:
	@jekyll serve --trace --future

serve-global:
	@jekyll serve --trace --host=0.0.0.0 --port=$(PORT) --future

clean:
	@rm -rf _site

.PHONY: default install-dev uninstall-dev all build serve serve-global clean
