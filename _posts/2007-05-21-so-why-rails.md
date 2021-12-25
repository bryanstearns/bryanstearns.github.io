---
published: true
title: So why Rails?
date: "2007-05-21 21:10:54 -0700"
---

I came from a background of web applications, and after
<a href="http://conferences.oreillynet.com/os2006/">OSCON</a>
last year, I spent some time looking into <a href="http://www.djangoproject.com/"
target="_blank">Django</a>, mostly because I'd heard a lot of good things about
Rails, and Django was said to be "like Rails, only written in Python" (the
language we're using for Chandler).<!--more-->

I'd initially been put off by Rails' self-proclaimed "opinionated" nature,
worried that their "convention over configuration" would only work for the things
I wanted to do that aligned with what they expected.

So, as a learning experiment, I rewrote my film-festival-scheduling application
in Django. I liked it, but once I was done I decided to look into Rails, to see
what was different about it. Also, I'd gotten to the point that I wanted to add
some AJAXy features to the scheduler, but Django didn't have direct support for
any particular AJAX library. That forced me to pick one myself, so I started
looking at the most-visible four or five libraries out there (Dojo,
Prototype/script.aculo.us, etc.).

Dojo looked the most interesting at the time, but I noticed that Rails had
picked Prototype and script.aculo.us -- and when I looked at a tutorial or two,
I saw that the integration looked pretty tight. This enticed me to watch the
Rails tutorial video... which inspired me to look again at the Ruby language,
and it all seemed pretty cool.

So, I rewrote the festival scheduler again, in Ruby, using Rails. I found that
the "opinionated" nature of Rails doesn't seem to get in my way; actually, it's
just the opposite: I learned quickly that if I was banging my head against the
way Rails worked, I was probably working against Rails, and that there was
probably a better way. There usually was, so this newfound sense of smell really
helped me get productive quickly.

(I've got more work to do on the festival scheduler, but I do expect to open
it up to others before too long. When I do, I'll announce it here.)
