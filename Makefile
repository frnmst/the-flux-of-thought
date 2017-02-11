#!/usr/bin/make -f

# Copyright (c) 2017 Franco Masotti.
# See LICENSE file for details.

all:
	@jekyll build
	@jekyll serve

clean:
	@rm -rf _site
