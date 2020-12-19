---
title: Download this Theme
updated: 2020-02-05 20:21
categories:  Download
tags: [download, terminal, image from another post]
---

The Plain Libre is just another white clean and minimalist Jekyll theme that
designed to focus on writing matters. This theme is best use for personal blog
type. No local or remote font is served.

> **_Fork_** or **_download_** the theme [**here**](https://github.com/frnmst/the-flux-of-thought).

<!--more-->

Let's call an image from antoher post using the liquid language

{% include image.html file="2017-02-11-another-post/terminal.png" alt="Terminal" caption="A terminal image from the other post" otherpost=true %}

This is the tag:

```liquid
{% raw %}
    {% include image.html file="2017-02-11-another-post/terminal.png" alt="Terminal" caption="A terminal image from the other post" otherpost=true %}
{% endraw %}
```
