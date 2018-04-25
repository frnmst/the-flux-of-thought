#!/usr/bin/make -f

# Copyright (c) 2017 Franco Masotti.
# See LICENSE file for details.

all: build serve

build:
	@jekyll build -V --safe -t

serve:
	@jekyll serve

serve-global:
	@jekyll serve --host=0.0.0.0 --port=3050

clean:
	@rm -rf _site
