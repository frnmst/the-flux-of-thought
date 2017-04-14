---
title: Download this Theme
updated: 2017-04-14 17:39
categories:  Download
tags: [download, terminal, image from another post]
---

The Plain Libre is just another white clean and minimalist Jekyll theme that 
designed to focus on writing matters. This theme is best use for personal blog 
type. Font or typeface used is HiloDeco.

> **_Fork_** or **_download_** the theme [**here**](https://github.com/frnmst/the-plain-libre).

<!--more-->

Let's call an image from antoher post using the liquid language

{% include image.html file="2017-02-11-another-post/terminal.png" alt="Terminal" caption="A terminal image from the other post" otherpost=true %}

This is the tag:

```liquid
{% raw %}
    {% include image.html file="2017-02-11-another-post/terminal.png" alt="Terminal" caption="A terminal image from the other post" otherpost=true %}
{% endraw %}
```
