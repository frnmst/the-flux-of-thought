---
title: This is another post
updated: 2017-04-09 23:00
categories: Other
tags: [other, liquid, terminal]
---

Hello again!

You can use markdown as well as liquid to render local images. The preferred 
method in this case is to use liquid.
 
![ter]({{ site.baseurl }}/media/2017-02-11-another-post/terminal.png)

{% include image.html file="terminal.png" alt="ter" caption="A terminal example caption" %}

Some other text below the caption. Is it rendered fine?

{% include image.html file="terminal.png" alt="ter" %}

This is the liqid tag for the last case:

```liquid
{% raw %}
    {% include image.html file="terminal.png" alt="ter" %}
{% endraw %}
```

