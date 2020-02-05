---
layout: default
permalink: index.html
excerpt: none
---

# {{ site.title }}

## Tags

{% include tag_list.html %}

## Years

<div class="index" markdown="0">
{% assign i=0 | plus: 0 %}

{% for post in site.posts %}
    {% assign open_list = false %}

    {% assign current_year=post.date | date: '%Y' %}
    {% if post.next %}
        {% assign next_year=post.next.date | date: '%Y' %}
    {% endif %}

    {% if i != 0 %}
        {% if post.next %}
            {% if current_year != next_year %}
                </ul>
            {% endif %}
        {% endif %}
    {% endif %}

<div markdown="1">
    {% if i == 0 %}
### {{ current_year }}
        {% assign open_list = true %}
    {% elsif post.next %}
        {% if current_year != next_year %}
### {{ current_year }}
            {% assign open_list = true %}
        {% endif %}
    {% endif %}
</div>

    {% if open_list %}
        <ul class="post-list">
    {% endif %}

    <li>
{% comment %}See http://frontendcollisionblog.com/jekyll/snippet/2015/03/23/how-to-show-a-summary-of-your-post-with-jekyll.html
             which is released under the MIT license, Copyright (c) 2015 Joshua Beam
{% endcomment %}
{% capture post_excerpt %}
{% if post.content contains site.excerpts.start and post.content contains site.excerpts.end %}
    {% assign start=post.content | split: site.excerpts.start | last %}
    {% assign end=start | split: site.excerpts.end | first %}
    {{ end | strip_html }}
{% else %}
    {{ post.content | strip_html | truncatewords: site.excerpts.words }}
{% endif %}
{% endcapture %}
        <a href="{{ post.url | prepend: site.baseurl }}.html">
[ {{ post.date | date: "%F" }} ] {{ post.title }} { {{ post_excerpt }} }
        </a>
    </li>

    {% if post.next == false %}
        </ul>
    {% endif %}

    {% assign i=i | plus: 1 %}
{% endfor %}
