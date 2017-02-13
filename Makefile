#!/usr/bin/make -f

# Copyright (c) 2017 Franco Masotti.
# See LICENSE file for details.

all: build serve

build:
	@jekyll build

serve:
	@jekyll serve

clean:
	@rm -rf _site
