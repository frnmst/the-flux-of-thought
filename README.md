# The Flux Of Thought

A full redesign of [the-plain-libre](https://github.com/frnmst/the-plain-libre) 
Jekyll theme.

## Table of contents

<!--TOC-->

- [The Flux Of Thought](#the-flux-of-thought)
  - [Table of contents](#table-of-contents)
  - [Demo](#demo)
  - [Philosophy](#philosophy)
  - [Versions](#versions)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
    - [Arch Linux based distros](#arch-linux-based-distros)
  - [Upgrading](#upgrading)
    - [Upgrading from Jekyll 3.x to Jekyll 4.x](#upgrading-from-jekyll-3x-to-jekyll-4x)
    - [Upgrading from the flux-of-though 0.x to 1.x](#upgrading-from-the-flux-of-though-0x-to-1x)
    - [Upgrading from the flux-of-though 1.x to 2.x](#upgrading-from-the-flux-of-though-1x-to-2x)
  - [Building and serving](#building-and-serving)
    - [Locally](#locally)
    - [GitLab Pages](#gitlab-pages)
  - [Tutorial](#tutorial)
    - [Commenting system](#commenting-system)
      - [Overview](#overview)
      - [Comment attributes](#comment-attributes)
    - [Media files](#media-files)
      - [Overview](#overview-1)
      - [File locations](#file-locations)
      - [Possible combinations](#possible-combinations)
      - [Calling files from another post](#calling-files-from-another-post)
      - [Notice and warning](#notice-and-warning)
    - [Static pages](#static-pages)
    - [Tags and categories](#tags-and-categories)
      - [Overview](#overview-2)
      - [The tags score system](#the-tags-score-system)
        - [Until version `0.0.5`](#until-version-005)
        - [Since version `0.1.0`](#since-version-010)
      - [Tags page](#tags-page)
      - [Tags in posts](#tags-in-posts)
    - [Excerpts](#excerpts)
    - [Anchor headings](#anchor-headings)
    - [RSS feeds](#rss-feeds)
    - [Search Engine Optimizaition (SEO)](#search-engine-optimizaition-seo)
      - [meta and other SEO tags](#meta-and-other-seo-tags)
      - [Sitemap](#sitemap)
      - [robots.txt](#robotstxt)
    - [Mobile support](#mobile-support)
    - [Compressed HTML output](#compressed-html-output)
  - [Tests](#tests)
    - [HTML validation](#html-validation)
  - [This version compared to the The Plain Libre](#this-version-compared-to-the-the-plain-libre)
  - [Useful resources](#useful-resources)
  - [Copyright and License](#copyright-and-license)

<!--TOC-->

## Demo

https://frnmst.github.io/the-flux-of-thought/

## Philosophy

- No Javascript is used. See [The JavaScript Trap](https://www.gnu.org/philosophy/javascript-trap.html).
- No local fonts are served.
- No remote fonts are included (called).
- A very minimal CSS is served.


<a href="https://www.buymeacoffee.com/frnmst" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" style="height: 51px !important;width: 217px !important;" ></a>


## Versions

See all 
[the-flux-of-thought releases](https://github.com/frnmst/the-flux-of-thought/releases).

## Dependencies

The theme is known to work with the the packages listed here and they must 
be installed on your system.

| Package | Executable | Version command | Package Version |
|---------|------------|-----------------|-----------------|
| [Ruby](https://www.ruby-lang.org/en/) | `/bin/ruby` | `$ ruby --version` | `ruby 2.6.5p114 (2019-10-01 revision 67812)` |
| [RDoc](https://ruby.github.io/rdoc/) | `/bin/rdoc` | `$ rdoc --version` |  `6.2.0` |
| [Jekyll](https://jekyllrb.com/) | `~/.gem/ruby/2.5.0/bin/jekyll` | `$ jekyll --version` | `jekyll 4.0.0` |
| [Jekyll Sitemap Generator Plugin](https://github.com/jekyll/jekyll-sitemap) | - | - | `1.4.0` |
| [GNU Make](http://www.gnu.org/software/make) | `/bin/make` | `$ make --version` | `GNU Make 4.2.1` |
| [krmadown](https://kramdown.gettalong.org/index.html) | `~/.gem/ruby/2.5.0/bin/kramdown` | `$ kramdown --version` | `2.1.0` |
| [Rouge](https://github.com/jneen/rouge) | `~/.gem/ruby/2.5.0/bin/rougify` | `$ rougify --version` | `3.13.0` | 

## Installation

### Arch Linux based distros

    # pacman -S ruby ruby-rdoc
    $ gem update
    $ gem install jekyll jekyll-sitemap kramdown rouge

## Upgrading

### Upgrading from Jekyll 3.x to Jekyll 4.x

In case you get something like `'private': nil is not a symbol nor a string (TypeError)`,
run:


    $ gem uninstall forwardable --version 1.3.0
    $ gem install forwardable --version 1.2.0


See also [this issue](https://github.com/jekyll/jekyll/issues/7930)
and [this document](https://jekyllrb.com/docs/upgrading/3-to-4/)

### Upgrading from the flux-of-though 0.x to 1.x

Yaml keys in the configuration file have changed. Be sure to to fix your configuration
file appropriately.

### Upgrading from the flux-of-though 1.x to 2.x

The original CSS has been replaced with a minimal CSS. See [this](https://webdesign.tutsplus.com/articles/undress-to-impress-check-your-websites-without-css--cms-22489)

## Building and serving

### Locally

Local serving, on `127.0.0.1`

    $ make

Global serving, on `0.0.0.0`

    $ make serve-global

Connect to `http://127.0.0.1:5555/the-flux-of-thought/`.

### GitLab Pages

If you use [GitLab Pages](https://about.gitlab.com/product/pages/) put the 
following in `./.gitlab-ci.yml`. See also https://gitlab.com/pages/jekyll

```
image: ruby:2.6

test:
  stage: test
  script:
  - gem install 'jekyll:4.0.0' jekyll-sitemap 'forwardable:1.2.0'
  - jekyll build -d test
  artifacts:
    paths:
    - test
  except:
  - master

pages:
  stage: deploy
  script:
  - gem install 'jekyll:4.0.0' jekyll-sitemap 'forwardable:1.2.0'
  - jekyll build -d public
  artifacts:
    paths:
    - public
  only:
  - master
```

## Tutorial

### Commenting system

#### Overview

This theme handles comments in the most static way possible: 
a `mailto` unique link is generated for each post, using the address specified 
in the `_config.yml` file. This idea came out while 
reading [this](https://caurea.org/2012/03/31/this-blog-has-comments-again.html) 
page.

Moreover, for each post a comment section gets exposed. To get comments inside 
this section, you must create a new file in the `_comments` directory using the 
corresponding posts path name as file name. Let's say a user sends a comment
for the `another-post` post. The `mailto` link will have this structure:

    <your_email_username>+2017-02-11-another-post@gmail.com

This works for any mailer system supporting these kind of mail
aliases, for example GMAIL.

You may notice the substring `2017-02-11-another-post` after the email 
username which is part of the post's file name:

    ./_posts/2017-02-11-another-post.md

Let's ingnore the `./_posts/` and `.md` substrings for a moment and save 
`2017-02-11-another-post` somewhere. Since a post may have more than a 
comment, we must distinguish between one and another. To do this we create a 
new directory using the comment path, like the following:

    $ mkdir _/comments/2017-02-11-another-post

and we will save the comment files inside to keep things tidy.

We then create a new markdown file corresponding to the comment, and its 
file name will be used as an id, for example:

    0.md

The filename must not have whitespace characters and the substring `.md` except 
at the end of it.

Out final comment path is:

    ./comments/2017-02-11-another-post/0.md

As a final remark you may have noticed that each comment is referenced as a 
paragraph (using the HTML `id` attribute) and that markdown is enabled by 
default.

#### Comment attributes

Comment files have 5 attributes:

- `layout`
  - Always use `comment` as variable.

- `date`
  - Use the format reported by the following date command:

        $ date "+%F %T %z"

- `from`
  - string representing the name or the id or the mail of the person that 
    commented the post.

- `subject`
  - String representing the mail subject.

For example:

    ---
    layout: comment
    title: This is another post
    date: 2017-02-11 23:37:05 +0100
    from: x.y@y.x, A Mailer
    subject: test subject
    ---

    This is a test comment for the `Hello again` post.

    ```python
    def hi
    ```

### Media files

Extending [these](https://eduardoboucas.com/blog/2014/12/07/including-and-managing-images-in-jekyll.html) 
ideas I came up with the following:

#### Overview

Just like comments, each media file is contained in one directory corresponding 
to a post. However, unlike comments, media content may be referenced from more 
than one post. This is how it works.

#### File locations

If out example post is `./_posts/2017-02-11-another-post.md` and we want to add 
media files to it, we must create a corresponding directory in `_media`:

    ./_media/2017-02-11-another-post

We can now place our file inside, for example:

    ./_media/2017-02-11-another-post/terminal.png

#### Possible combinations

Now, let's go back to `./_posts/2017-02-11-another-post.md`. To be able to 
display that picture we need to use the `include` liquid tag. In the simplest 
form the only required parameter is the file name:

```liquid
{% include image.html file="terminal.png" %}
```

You can also use the `alt` and/or `capiton` tags:

```liquid
{% include image.html file="terminal.png" alt="ter" caption="A terminal example caption" %}
```

You can also use plain markdown, which is not advisable in this case, since 
you need to input the whole path:

    ![ter]({{ site.baseurl }}/media/2017-02-11-another-post/terminal.png)

#### Calling files from another post

In some cases you may want to recall media files from another post. You can do 
that using the `otherpost` tag. Let's say we are in the 
`./_posts/2015-09-09-download-this-theme.md` post.

```liquid
{% include image.html file="2017-02-11-another-post/terminal.png" alt="Terminal" caption="A terminal image from the other post" otherpost=true %}
```

As you can see you don't have to specify the full path but only the post name 
slash the file name. The rest is filled in automatically.

Finally, notice the `otherpost=true` tag at the end.

#### Notice and warning

If you do not include the `alt` tag a default one will be provided instead.

This include feature is currently available only for images (`img` HTML tag).

### Static pages

Reading [this](https://mademistakes.com/articles/using-jekyll-2016/#pages-for-everything-else)
gave me the idea to move the static pages like index, 404, etc.. in the 
`./_pages` directory. If you want to add new pages remember to add a sensible 
`permalink` for each page and remember to keep `include: [ "_pages" ]`
and:

    collections:
      pages:
        output: false

in the `_config.yml` file.

### Tags and categories

#### Overview

In this theme tags and categories are considered the same thing. I will use the 
word *tag* to speak about both tags and categories.

I gathered some ideas from [here](https://blog.webjeda.com/jekyll-categories/) 
and using the official Jekyll documentation.

A list of tags is present on the home page, i.e: `./_pages/index.html`. 
This list is just a set of links pointing to the appropriate entry in the 
`./_pages/tags.md` page.

#### The tags score system

A list of tags is present on the home page, i.e: `./_pages/index.html`. 
This list is just a set of links pointing to an appropriate entry in the 
`./_pages/tags.md` page, which are presented using a *score* criteria. All 
occurrencies of a tag are counted globally. If that frequency is greater or 
equal than the `tags.score.min` variable in the `_config.yml` file then the tag
list element is showed along with its score. On the other hand if the frequency
is less than `tags.score.min` the tag will not be shown. If you want all the
tags to be shown, simply set `tags.score.min` to `1`.

You can limit the number of tags from home and tags page by setting the 
`tags.score.link_limit` variable to a positive integer number. If you set it `false`
the tags will not be limited.

You may have noticed that the tag list is presented in a descreasing number of
occurrencies per tags. This method was chosen so that the relevant content
is shown first.

##### Until version `0.0.5`

Until version `0.0.5`, the logic for all this was adapted from 
[here](https://raisedbyturtles.org/shopify-associative-arrays)
and 
[here](https://stackoverflow.com/questions/48529507/jekyll-show-post-count-for-sub-categories).

##### Since version `0.1.0`

Since version `0.1.0` sorting is done first by *tag score* and then
alphabetically. 

Some elements of logic were taken from [here](https://stackoverflow.com/questions/42846888/repeat-string-multiple-times-in-jekyll), 
[here](https://www.matthewsessions.com/blog/liquid-slice-array/), 
[here](https://stackoverflow.com/questions/54769586/how-to-display-tags-in-jekyll-and-get-the-tag-to-click-through-to-all-relevant-c), 
[here](https://gist.github.com/sskylar/8956549d1ae9dc91c89e74b1c5a0d8c9) 
and the official [Liquid documentation](https://shopify.github.io/liquid/).

#### Tags page

The purpose of this page is to present links to posts for each tag in the 
website. This page reports *all* tags in the website without the *tags score*
system except that the list will be sorted with descreasing frequency.
The tags reported on the top of the page follow the *tags score* system.

Below the tags list there are links to each posts, organized by tags. If a user 
clicks on one of the links in the tags list, the viewport will be moved to the
list of posts containing that tag.

#### Tags in posts

If a post contains at least one tag, this will be reported at the top of the 
page with a link pointing to the appropriate bookmark of `./_pages/tags.md` 
(just like in the home page). A user looking at a post can see all related 
posts just by clicking at those tag links.

The tag entry is optional which means that you can specify from 0 to n tags. If 
you want to add some, simply write your comma separated list of tags in the 
front matter of your post:

    tags: [tag 0, tag 1, ... , tag n]

Let's make an example. What follows is the front matter of the
`./_posts/2015-09-09-download-this-theme.md` post.

    ---
    title: Download this Theme
    updated: 2017-04-09 00:29
    categories:  Download
    tags: [download, terminal, image from another post]
    ---

As you may have noticed, tags can contain spaces.

Once you run make, you should see the following links
just below the `Download this Theme` title:

    *download* *terminal* *image from another post*

### Excerpts

An excerpt is a portion of a post reported in the home page.

Any content between `<!--excerpt_start-->` and `<!--excerpt_end-->` tags 
in a post will be used as excerpt.

If one or both of these tags are omitted, the first 20 words of the post will be reported 
instead. You can specify the number of words in the excerpt by editing the 
`excerpts.words` variable in the `./_config.yml` file.

If you are not interested in excerpts set the `excerpts.enabled` variable to 
false in `./_config.yml`.

The liquid code that handles the excerpts was inspired by
[this article](http://frontendcollisionblog.com/jekyll/snippet/2015/03/23/how-to-show-a-summary-of-your-post-with-jekyll.html).
Here is its license and copyright:

```
The MIT License (MIT)

Copyright (c) 2015 Joshua Beam

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

### Anchor headings

Anchor headings are clickable links beside a `<h[1-6]>` tag. The purpose of 
these elements is to get a quick link to a specific part of a page.

You can modify the appearence of these links from the `./_config.yml` file 
through the `anchor_headings` variables.

All this is possible thanks to the 
[Jekyll Pure Liquid Heading Anchors](https://github.com/allejo/jekyll-anchor-headings)
library.

### RSS feeds

This theme contains an Atom file useful for RSS feeds in `./_pages/feed.xml`.

The link to `feed.xml` is available in the navigation bar of every page.
The purpose is that your readers open this link with a feed reader so that 
they can remain up to date with your posts.

### Search Engine Optimizaition (SEO)

I'm a noob in this field so I followed 
[this](https://blog.webjeda.com/optimize-jekyll-seo/) tutorial
and [this](https://varvy.com/) SEO checker.

- meta
- sitemaps
- images
  - always use alt tags. For images in `./_assets` these are already coded 
    in.
- responsiveness
  - the theme is reported
    [responsive by Google](https://search.google.com/test/mobile-friendly)
- robots.txt

#### meta and other SEO tags

meta tags are available in the `./_includes/head.html` file. These include:
`title`, `description` and canonical links.

The description meta tag uses the first available, in this order, of the 
following:
- Front matter `description` tag
- Page excerpt
- Site description

It is advised to use the `description` tag since excerpts or the site 
description may not relate to the (whole) page content. Here's an example:

    ---
    title: This is another post
    updated: 2017-04-09 23:00
    tags: [other, liquid, terminal]
    description: How to use markdown and liquid to render images belonging to a 
    post.
    ---

You can also edit the `meta` variable in `./_config.yml`to limit the number  
of words in the `description` meta tag. Avoid values greater than `160` as 
reported by previously cited articles:

#### Sitemap

A sitemap used for web crawlers is available thanks to the 
[jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap) plugin.

There is also a (very) basic sitemap for users under the `/sitemap/` permalink
which has a link for it at the top of each page.

#### robots.txt

This very important file must be put under the root of your domain. It is used 
by web crawlers (a.k.a bots, spiders, etc) to get access information about the 
website. In our case it is also important to tell these programs that our site
has a `sitemap`. Read [this](http://www.robotstxt.org/robotstxt.html) 
and
[this](https://support.google.com/webmasters/answer/6062596?hl=en&ref_topic=6061961)
for more information.

For example, since this project is called `the-plain-libre` and is published
under `https://frnmst.github.io/the-plain-libre`, we need to put the robots.txt
file just under `https://frnmst.github.io/`, i.e

    https://frnmst.github.io/robots.txt

Since I didn't have neither a "user page" nor a domain I created a dummy [user 
page](https://github.com/frnmst/frnmst.github.io) repository and I copied the 
`robots.txt` file from the generated `./_site` directory from Jekyll. This 
works for me. This means that in my case the `robots.txt` in this repository is 
ignored by the bots.

I guess that if you have multiple repository pages you can edit 
the robots.txt file appropriately and set rules (and sitemap locations) for 
each one of them.

### Mobile support

Mobile support is available for this theme through the CSS file through the
`@media` rules.

### Compressed HTML output

By default Jekyll leaves lots of whitespace in the html source. You can verify 
this yourself.

Since useless white space means useless data -> we transmit useless bytes -> 
loading the website requires more time.

For this reason I decided to use a compressed html output thanks to 
[jekyll-compress-html](https://github.com/penibelst/jekyll-compress-html),
which is a pure liquid layout to be used as a wrapper on the 
`./_layouts/default.html` layout.

jekyll-compress-html is released under the MIT license.

## Tests

This theme is guaranteed to work correctly with the following web browsers:

| OS | Browser | Executable | Version command | Browser Version |
|----|---------|------------|-----------------|-----------------|
| [Parabola GNU/Linux-libre](https://parabola.nu) | [Iceweasel](https://wiki.parabola.nu/iceweasel) | `/bin/iceweasel` | `$ iceweasel --version` | `Mozilla Iceweasel 61.0.2` |
| [Parabola GNU/Linux-libre](https://parabola.nu) | [GNU Icecat](http://www.gnu.org/software/gnuzilla/) | `/bin/icecat` | `$ icecat --version` | `GNU icecat 60.3.0` |
| [Parabola GNU/Linux-libre](https://parabola.nu) | [w3m](https://salsa.debian.org/debian/w3m) | `/bin/w3m` | `$ w3m -version`| `w3m version w3m/0.5.3+git20180125` | 
| [Android 8.1.0](https://developer.android.com/about/versions/oreo/android-8.1) | [Firefox Klar](https://www.mozilla.org/en-US/firefox/mobile/) | - | - | `6.1.1` |

### HTML validation

This Jekyll theme has been checked with the [HTML5 W3C validator](https://validator.w3.org/nu/)

## This version compared to the The Plain Libre

There are too many things to compare, but in short terms:

- the CSS file was written from scratch.
- some Liquid templating language parts have been changed also because of the 
  new CSS.
- new tags score system for the index page.

## Useful resources

- https://www.w3.org/
- Especially useful for CSS examples: https://www.w3schools.com/default.asp 

## Copyright and License

The MIT License (MIT)

Copyright (c) 2015 Heiswayi Nrird

Copyright (c) 2017-2020 Franco Masotti <franco.masotti@live.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
