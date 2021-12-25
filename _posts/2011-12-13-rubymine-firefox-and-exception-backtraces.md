---
published: true
title: RubyMine, Firefox, and Exception Backtraces
date: "2011-12-13 17:21:21 -0800"
---

I use <a href="http://www.jetbrains.com/ruby/">RubyMine</a> and
<a href="http://getfirefox.com">Firefox</a> for most of my
day-to-day Ruby on Rails development, and in spite of my best efforts, I
sometimes get exceptions that result in the display of Ruby backtraces instead
of the web page I asked for.<!--more-->

While the backtrace helpfully lists the places in my code (or Rails, or the Ruby
libraries, etc) that we traversed on the way to the crash site, opening the
file in RubyMine to see more context requires copying the path, invoking a
RubyMine keyboard shortcut for open-file, and pasting. Work.

After a lot of this copy and pasting, it occurred to me to join Firefox's
ability to invoke a program for a particular URL scheme, and the command-line
wrapper that RubyMine can produce to open files in a running RubyMine instance.

<a href="https://gist.github.com/1474782">This gist</a> is the
result: it's a Rails initializer that produces "mine:" links in backtraces.
It starts with instructions on setting up Firefox and the RubyMine wrapper;
once you've followed them, you'll get links in the backtrace that'll take you
directly to the source where an exception occurred.

(Note: I'm using this while working on a Ruby 1.8.7 / Rails 2.3.4 application,
and as you can see, it monkey-patches the backtrace functions in Exception; I
fully expect to have to update it for newer Ruby and Rails versions - if you
find that changes are needed, or have other suggestions, please let me know
in a comment. Thanks!)
