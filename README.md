# The Plain Libre

The Plain is just another white clean and minimalist Jekyll theme that 
designed to focus on writing matters. This theme is best use for personal blog 
type.

[Original version](https://github.com/heiswayi/the-plain)

## This version compared to the original one

- Removed all analytics
- Removed Google font
- Removed Gravatar
- Removed MathJax
- Added a few personalizations
  - Changed main font
  - Bigger font rendering
  - Changed background colors
  - `outline: none` for links
  - Static comment system

## Commenting system

### Overview

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

You may notice the substring `2017-02-11-another-post` after the gmail's email. 
This string is part of the file name corresponding to the post which is:

    ./_posts/2017-02-11-another-post.md

Let's ingnore the `./_posts/` substring for a moment and save 
`2017-02-11-another-post.md` somewhere. Since a post may have more than a 
comment, we must distinguish between one and 
another. To do this we identify each comment by adding a new 
substring to the comment path, for example:

    2017-02-11-another-post_0.md

The separator between the id `0` and the rest of the path must always be `_`.
If you receive another comment you can use `1`, and so on. Using numbers is 
just a convention, you may use any string in this case.

Out final comment file name is:

    ./comments/2017-02-11-another-post_0.md

As a final remark you may have noticed that each comment is referenced as a 
paragraph and that markdown is enabled by default.

### Comment attributes.

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

## Avatar

Use a square avatar in `./assets/avatar.jpg` (more coming soon).

## Local media content

Put your local media content in `./assets/posts` and use the posts' name as 
prefix to the files. You should then reference these files form the `_posts`
directory easily.

## Theme installation

    # pacman -S ruby
    $ gem update
    $ gem install jekyll jekyll-sitemap

## Building

    $ make

## TODO

- Tags and categories.
- Add link to cc-by-sa page on respective picture.
- Misc.

## Screenshot

TODO

## License

Copyright (C) 2017, Franco Masotti <franco.masotti@student.unife.it>

[MIT](LICENSE.md)
