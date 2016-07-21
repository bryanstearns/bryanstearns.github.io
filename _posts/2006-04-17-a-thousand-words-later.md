---
published: true
title: A thousand words later
date: '2006-04-17 09:04:22 -0700'
---
![Reflection in Cloud Gate]({{ "/images/2015/03/bean_reflection1.jpg" | prepend: site.baseurl }}){: .thumb}
Over the weekend, I wrote my own photo-inserting plugin for Wordpress. I did my
own because I keep all my digital photos in one place (and wanted to keep it
that way without having all of them publicly available; I also wanted the
mechanism to generate and serve lower-resolution (so lower-bandwidth) versions
automatically.<!--more-->

The plugin does that: I start my post with something like `{gallery Chicago2004/IMGP0347}`
and the plugin takes care of substituting appropriate XHTML markup to retrieve
a thumbnail version of the photo (which it also generates), adding on a secret
code that'll keep people from browsing for similarly-named photos (I might not
want you to see IMGP0346 or IMGP0348). The generated markup also includes a
little Javascript to pop open a larger (but reduced resolution) view in its
own window.

Next step: set up a mechanism to handle incoming mail from my Sidekick, so that
I can publish a post with photos automatically.

(That's Gina and I reflected in the
<a href="http://www.cityofchicago.org/city/en/depts/dca/supp_info/millennium_park_-artarchitecture.html#cloud"
target="_blank">big shiny jellybean</a> in Chicago's Millenium Park.)

Update, December 10, 2013: I've rebuilt my blog on a current version of
Wordpress, and I've ditched that plugin: I'm just using WordPress's regular
media management now. (Another news flash: I no longer use a Sidekick.)

Update, July 21, 2016: I've rebuilt my blog using Jekyll, so none of the above
really matters anymore, but I've left it because it's fun to see what I used
to spend time on :-). I did update the Cloud Gate link to one that works now.
