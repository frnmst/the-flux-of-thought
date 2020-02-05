---
layout: page
title: Tags
permalink: /tags/
---

{% include tag_list.html %}

<hr>

<div>

{% assign site_tags = site.tags | sort %}

{% for tag in site_tags %}
   <h3 id="{{ tag[0] | slugify }}">{{ tag[0] }}</h3>
   <ul>
   {% assign tag_name = tag | first %}
   {% for post in site.tags[tag_name] %}
        <li>
            <a href="{{ post.url | prepend: site.baseurl }}.html">{{ post.title }}</a>
        </li>
   {% endfor %}
    </ul>
{% endfor %}

</div>

