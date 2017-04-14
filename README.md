# The Plain Libre

The Plain Libre is just another minimalist Jekyll theme that 
designed to focus on writing matters. This theme is best use for personal blog 
type, it relies on free software only and does not include
any Javascript. The font used is served from the local instance.

[Original version](https://github.com/heiswayi/the-plain)

## This version compared to the original one [1443d83](https://github.com/frnmst/the-plain-libre/commit/1443d83ec881a7bfd4b62975da29f72f8f99d38a)

- Removed all analytics
- Removed Google font
- Removed Gravatar
- Removed MathJax
- Changed main font
- Bigger font rendering
- Changed background colors
- `outline: none` for links
- Simpler image handling
- Last post update shown
- Static commenting system
- Full tag support
- Lists style CSS: `circle` instead of `disk`
- Excerpts support

### TODO

- Full category support
- Search Engine Optimization (SEO)
- CNAME?
- shell scipt that builds example posts, images (base64 or similar), etc using:

      cat <<-EOF
      # whatever
      EOF

  so that examples and real blog content can be decoupled.
  This script will be called using the Makefile.

## Theme installation

    # pacman -S ruby
    $ gem update
    $ gem install jekyll jekyll-sitemap

## Building

    $ make

## Screenshots

TODO

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
`_posts/2015-09-09-download-this-theme.md` post.

```liquid
{% include image.html file="2017-02-11-another-post/terminal.png" alt="Terminal" caption="A terminal image from the other post" otherpost=true %}
```

As you can see you don't have to specify the full path but only the post name 
slash the file name. The rest is filled in automatically.

Finally, notice the `otherpost=true` tag at the end.

#### Warning

This feature is currently available only for images.

### Static pages

Reading [this](https://mademistakes.com/articles/using-jekyll-2016/#pages-for-everything-else)
gave me the idea to move the static pages like index, 404, etc.. in the 
`_pages` directory. If you want to add new pages remember to add a sensible 
`permalink` for each page and remember to keep `include: [ "_pages" ]`
and `collections: pages: output: false` in the `_config.yml` file.

### Tags

#### Overview

I gathered some ideas from [here](https://blog.webjeda.com/jekyll-categories/) 
and using the official Jekyll documentation.

A full list of tags is present on the home page, i.e: `index.html`. This list 
is just a set of links pointing to the appropriate entry in the `tags.md` 
page. This page has that same list as well as links to each post 
belonging to a tag.

If a post contains at least one tag, this is reported at the top of the page 
with a link pointing to the appropriate bookmark of `tags.md` (just like in 
the home page).

#### Format

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
`excerpt_words` variable in the `_config.yml` file.

If you are not interested in excerpts set the `excerpt_enabled` variable to 
false in `_config.yml` file.

Have a look at 
[this article](http://frontendcollisionblog.com/jekyll/snippet/2015/03/23/how-to-show-a-summary-of-your-post-with-jekyll.html) 
for more ideas.

### Avatar

Use a squared avatar in `./_assets/avatar.jpg`.

## License

Copyright (C) 2017, Franco Masotti <franco.masotti@student.unife.it>

[MIT](LICENSE.md)

