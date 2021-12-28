---
published: true
title: What's in the box
date: "2006-04-08 12:38:26 -0700"
category: General
---

I run this server myself, as an educational experience; I expect that a fair
number of posts on this blog will relate to things I've learned while working
on it. I'll file these posts in this "Meta" category: blogging about blogging,
as well as the other server stuff underneath it.

For now, here's a list of the mechanisms on this server, many of which will
soon be described in more detail in other posts:<!--more-->

- This blog, of course, but also a few other folks' sites, including Gina's
  <a href="http://foodiesf.com">foodie book club</a>
- My webcam, and the image-processing stuff around it
- A backup mechanism that copies everything to my file server, as well as an
  offsite location, every night
- A setup mechanism that allows me to rebuild the server from scratch in about
  an hour, with no interaction
- A mail server, running Postfix, SpamAssassin, ClamAV, etc
- My <a href="http://mythtv.org">MythTV</a> backend, which will
  eventually replace my TiVo
- A <a href="http://subversion.tigris.org">Subversion</a>
  repository (eventually I'll set up external access to share more of what I've
  made)
- Various other web applications that I'll describe later (buzzwords:
  <a href="http://www.djangoproject.com/">Django</a> &amp;
  <a href="http://www.edgewall.com/trac/">Trac</a>)

The server runs <a href="http://www.ubuntu.com/">Ubuntu Linux</a>
(currently, the Breezy Badger version); it's a Dell SC-420 Pentium 4 box with
1G RAM and about 300GB storage.

Update, July 21, 2016: None of the foregoing is true anymore:

- Though I do still have a home server, this blog is built by Jekyll and
  produces static files served by GitHub Pages. (Also, there's no longer a
  "Meta" category, as I've ditched categories!)
- The webcam went away after our fantastic view went away
- There is still a backup mechanism that backs up databases to Amazon S3 every
  night, and I still use a custom automated setup mechanism (that now provisions
  Docker containers for all the pieces)
- I got tired of running my own mail server; I just use Gmail now.
- Likewise, TiVo won out over hand-managing mythtv
- Heh, it's all `git` now - haven't Subversioned in forever.
- My server at home hosts Festival Fanatic (still Ruby & Rails), and a few
  internal sites (some Ruby, but a growing number are built with Elixir and
  Phoenix).
- It's still a Dell, but it's a now-old XPS Studio MT-435 with 12G RAM & a 256G
  SSD; it still runs Ubuntu, but it's the Vivid Vervet now - wow, they've come
  a long way!
