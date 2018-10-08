---
layout: page
title: Sitemap
permalink: /sitemap/
---

{% assign site_pages = site.pages | sort %}
### Pages
<ul>
{% for page in site_pages %}
    {% if page.title != 404 %}
<li>
<a href="{{ page.url | prepend: site.baseurl }}">{{ page.title }}</a>
</li>
    {% endif %}
{% endfor %}
</ul>

{% if site.posts %}
    {% assign site_posts = site.posts | sort %}
### Posts
<ul>
    {% for post in site_posts %}
<li>
<a href="{{ post.url | prepend: site.baseurl }}.html">{{ post.title }}</a>
</li>
    {% endfor %}
</ul>
{% endif %}
