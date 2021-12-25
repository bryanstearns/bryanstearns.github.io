---
published: true
title: The Android fonts on my desktop are beautiful
date: "2008-11-15 11:15:19 -0800"
---

![Android font sample]({{ "/images/2015/03/DroidGraphic300.jpg" | prepend: site.baseurl }}){: .thumb}

I've been tinkering with developing software for the Android phone platform
(and loving my G1 phone that runs it)... the Android folks at Google hired
Ascender to create a new font family for the phone, the only family that the
phone comes with.<!--more--> Here's a sample from
<a href="http://www.ascendercorp.com/pr/pr2007_11_12.html">Ascender's press release</a>.

It occurred to me that because the fonts were designed for legibility at small
point sizes, Droid Mono might be a good replacement for the terminal font I do
much of my programming in. It turns out that the whole family makes excellent
replacements for the default fonts on my Ubuntu systems: they're so legible
that I've been able to reduce the default sizes as well, effectively giving
me more screen real estate. Several times in the last couple of days, it's
occurred to me how much more beautiful my working environment is, now that
I'm looking at a well-designed font.

You can get the fonts from within the Android SDK, but another helpful blogger
has put them up as a <a href="http://damieng.com/blog/2007/11/14/droid-font-family-courtesy-of-google-ascender">separate download</a>. (If you're installing them on Linux like
I did, put them in a folder in /usr/share/fonts, then do `sudo fc-cache -f -v`
to get the system to notice them.)
