---
template: post.html
date: 2013-04-09
title: Philosophers influences on Wikipedia
slug: philosophers-influences
---

Lately I have been searching for many philosophers on Wikipedia. I found that a good way to browse through them is with the help of the 'Influenced' and 'Influenced by' parameters shown in the infoboxes on the right of a Wikipedia page:

<p style="text-align:center;"><img style="border:1px solid #EEE;" alt="Kierkegaard's influences" src="/assets/images/kierkegaard-influenced-by.png"></p>

Then I thought: wow, I could scrape and visualize this! (And have a good reason to use Python again.)

So I started downloading Wikipedia from a [torrent](https://meta.wikimedia.org/wiki/Data_dump_torrents), a 40GB sized file when unpacked. I found a wikicode parser, called [mwparserfromhell](https://github.com/earwig/mwparserfromhell), and a nice graph library, called [Networkx](http://networkx.github.io/).

With these Python libraries I could collect all data and export it as a .<a href="http://en.wikipedia.org/wiki/DOT_(graph_description_language)">DOT-file</a>. First I started playing with [Graphviz](http://www.graphviz.org/), but it's much easier to load the data into [Gephi](https://gephi.org/). Gephi is a tool with a GUI; that has lots of options for layout, grouping, filtering, etc.

All the while I didn't search the web for other people who might have done something similar. Because you will always find that you weren't original and something else did it already. And that spoils the fun.

And of course, someone else had this idea too. [Simon Raper](http://drunks-and-lampposts.com/2012/06/13/graphing-the-history-of-philosophy/) did it first, it seems, and [Brendan Griffen](http://griffsgraphs.com/2012/07/03/graphing-every-idea-in-history/) took it even further. Their work looks really awesome.

They used [Dbpedia](http://dbpedia.org/), which is a great product I had never heard of. It's a structured dataset of many Wikipedia articles. In my dataset there is some noise; like redirects and influences that aren't persons, like Buddhism for example. Dbpedia does the work of filtering that out for you probably.

Anyway, it was fun to do. Here are some renderings.

![Schopenhauer in the graph](/assets/images/graph-schopenhauer.jpg)

![Graph made with the OpenOrd algorithm](/assets/images/philosophers-graph-openord.jpg)

Download:

- Full graph (with names) as <a href="/assets/files/philosophers-wikipedia-unfiltered-fruchrein.pdf" target="_blank">PDF</a>
- Data (unfiltered) as a <a href="/assets/files/philosophers-wikipedia-unfiltered.dot" target="_blank">DOT-file</a>
