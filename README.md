# The Flux Of Thought

A full redesign of [the-plain-libre](https://github.com/frnmst/the-plain-libre) 
Jekyll theme.

## Table of contents

[](TOC)

- [The Flux Of Thought](#the-flux-of-thought)
    - [Table of contents](#table-of-contents)
    - [Demo](#demo)
    - [Philosophy](#philosophy)
    - [Dependencies](#dependencies)
    - [Building and serving](#building-and-serving)
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
    - [This version compared to the The Plain Libre](#this-version-compared-to-the-the-plain-libre)
    - [Useful resources](#useful-resources)
    - [License](#license)

[](TOC)

## Demo

https://frnmst.github.io/the-flux-of-thought/

## Philosophy

- No Javascript is used.
- No local fonts are served.
- No remote fonts are included.
- Boxes with outer shades are clickable links.
- Boxes with inner shades are NOT clickable links.
- Any box without shades, inner or outer, is the navbar.

## Dependencies

On Parabola GNU/Linux-libre, you need to install the dependencies like this:

    # pacman -S ruby ruby-rdoc
    $ gem update
    $ gem install jekyll jekyll-sitemap

## Building and serving

Local serving (127.0.0.1)

    $ make

Global serving (0.0.0.0)

    $ make serve-global

Connect to `http://127.0.0.1:5555/the-flux-of-thought/`.

## Tutorial

### Commenting system

#### Overview

This theme handles comments in the most static way possible: 
a `mailto` link is generated for each post thanks to GMAIL mail aliases, using 
the address specified in the `_config.yml` file. This idea came out while 
reading [this](https://caurea.org/2012/03/31/this-blog-has-comments-again.html) 
page.

Moreover, for each post a comment section gets exposed. To get comments inside 
this section, you must create a new file in the `_comments` directory using the 
corresponding posts path name as file name. Let's say a user sends a comment
for the `another-post` post. The `mailto` link will have this structure:

    <your_gmail_email>+2017-02-11-another-post@gmail.com

You may notice the substring `2017-02-11-another-post` after the gmail's email 
(but it works for any mailer system supporting these kind of mail aliases).
This string is part of the file name corresponding to the post which is:

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

You can use any non spaced string, and avoid using `.md` except at the end of 
this file name.

Out final comment path is:

    ./comments/2017-02-11-another-post/0.md

As a final remark you may have noticed that each comment is referenced as a 
paragraph (using the id) and that markdown is enabled by default.

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

Extending [this](https://eduardoboucas.com/blog/2014/12/07/including-and-managing-images-in-jekyll.html) 
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
This list is just a set of links pointing to the appropriate entry in the 
`./_pages/tags.md` page and are presented using a "score" criteria. All 
occurrencies of a tag are counted globally. If that frequency is greater or 
equal than the `min_tag_score` variable in the `_config.yml` file then the tag
list element is showed along with its score. On the other hand if the frequency
is less than `min_tag_core` the tag will not be shown. If you want all the
tags to be shown, simply set `min_tag_core` to `1`.

You may have noticed that the tag list is presented in a descreasing number of
occurrencies per tags. This method was chosen so that the relevant content
is shown first.

The logic for all this was adapted from 
[here](https://raisedbyturtles.org/shopify-associative-arrays)
and 
[here](https://stackoverflow.com/questions/48529507/jekyll-show-post-count-for-sub-categories).

#### Tags page

The purpose of this page is to present links to posts for each tag in the 
website. This page reports *all* tags in the website without the "tags score" 
system except that the list will be sorted with descreasing frequency.

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

Excerpts are reported in the home page.

Use the `<!--more-->` tag inside a post to mark the end of the excerpt.

If this tag is omitted, the first 10 words of the post will be reported 
instead. You can specify the number of words in the excerpt by editing the 
`excerpt_words` variable in the `./_config.yml` file.

If you are not interested in excerpts set the `excerpt_enabled` variable to 
false in `./_config.yml`.

Have a look at 
[this article](http://frontendcollisionblog.com/jekyll/snippet/2015/03/23/how-to-show-a-summary-of-your-post-with-jekyll.html) 
for more ideas.

### Anchor headings

Anchor headings are clickable links beside a `<h[1-6]>` tag. The purpose of 
these elements is to get a quick link to a specific part of a page.
You can modify the appearence of these links from the `./_config.yml` file 
through the `anchor_headings_*` variables.

All this is possible thanks to the 
[Jekyll Pure Liquid Heading Anchors](https://github.com/allejo/jekyll-anchor-headings)
library.

### RSS feeds

This theme contains an Atom file useful for RSS feeds in `./_pages/feed.xml`

The link to `feed.xml` is available in the navigation bar of every page.
The purpose is that your readers open this link with a feed reader so that 
they can remain up to date with your posts.

### Search Engine Optimizaition (SEO)

I'm a noob in this field so I followed 
[this](https://blog.webjeda.com/optimize-jekyll-seo/) tutorial
and [this](ttps://varvy.com/) SEO checker.

- meta
- sitemaps
- images
  - always use alt tags. For images in `./_assets` these are already coded 
    in.
- responsiveness
  - the theme is reported
    [responsive by Google](https://search.google.com/test/mobile-friendly?id=mcEQCZtn8FzflLoGh3Boqw)
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

You can also edit the following variables in `./_config.yml`to limit the number  
of words in the `description` meta tag. Avoid values greater than `160` as 
reported by previously cited articles:

    meta_description_words
    meta_excerpt_words
    meta_site_description_words

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

It has been tested on Iceweasel for [Parabola GNU/Linux-libre](https://www.parabola.nu/)
and on Firefox Klar for Android.

## This version compared to the The Plain Libre

There are too many things to compare, but in short terms:

- the CSS file was written from scratch.
- some Liquid templating language parts have been changed also because of the 
  new CSS.
- new tags score system for the index page.

## Useful resources

- https://www.w3.org/
- Especially useful for CSS examples: https://www.w3schools.com/default.asp 

## License

Copyright (C) 2017-2018, Franco Masotti <franco.masotti@student.unife.it>

[MIT](LICENSE.md)

