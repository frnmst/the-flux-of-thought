---
layout: default
permalink: index.html
excerpt: none
---

<div class="index" markdown="1">
{% for post in site.posts %}
	{% unless post.next %}
### Year {{ post.date | date: '%Y' }}
	{% else %}
		{% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
		{% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
		{% if year != nyear %}
### Year {{ post.date | date: '%Y' }}
		{% endif %}
	{% endunless %}
<div markdown="0">
{% comment %}Start list here instead after "Year" to simplify liquid code. This works nonetheless.{%endcomment %}
<ul class="post-list">
<li>
<a href="{{ post.url | prepend: site.baseurl }}.html">
<span class="post-list-metadata">
<span class="post-list-title">{{ post.title }}</span>           
<span class="post-list-date">{{ post.date | date: "%b %d" }}</span>
<span class="post-list-div"></span>
            {% if site.excerpt_enabled %}
<span class="post-list-excerpt">
                {% if post.content contains site.excerpt_separator %}
                    {{ post.excerpt | strip_html }}
                {% else %}
                    {{ post.excerpt | strip_html | truncatewords: site.excerpt_words }}
                {% endif %}
</span>
            {% endif %}
</span>
</a>
</li>
</ul>
</div>
{% endfor %}
</div>
