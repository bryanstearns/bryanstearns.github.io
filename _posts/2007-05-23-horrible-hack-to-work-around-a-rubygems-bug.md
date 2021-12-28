---
published: true
title: Horrible hack to work around a RubyGems bug
date: "2007-05-23 18:11:20 -0700"
category: Coding
---

<a href="http://conferences.oreillynet.com/rails/">RailsConf</a>
inspired me to be more vocal in the community, and one way is for me to share
some of the problem workarounds I've come up with. Here's the first one, and
I'm posting it in spite of being ashamed of it!<!--more-->

I use an automated mechanism to set up my Ubuntu machines from scratch, but
I've had trouble with getting "gem install" to install the right version of
binary gems: in spite of my efforts to script it, it's been installing
"mswin32"-platform gems under Ubuntu. There's already a
<a href="http://rubyforge.org/pipermail/rubygems-developers/2007-April/002733.html"
target="_blank">discussion on the RubyGems list</a> about this, but I don't have
the experience with the gems architecture to help drive the decision; in the
meantime, I needed a fix..

This works for me, for now:

<!-- prettier-ignore-start -->
{% highlight ruby %}
# /usr/lib/ruby/site_ruby/1.8/rubygems/remote_install.rb, line 112:
# Find a gem to be installed by interacting with the user.
def find_gem_to_install(gem_name, version_requirement)
  specs_n_sources = specs_n_sources_matching gem_name, version_requirement
  # BJS: added: reject win32 gems
  specs_n_sources.delete_if { |item| item[0].platform=="mswin32" }
  # [...]
{% endhighlight %}
<!-- prettier-ignore-end -->

This makes "gem" ignore "mswin32"-platform gems. I apply the patch (in my
automated mechanism, of course), and if the apply fails, the install will fail,
so (assuming the real fix for this problem modifies remote_install.rb), I'll
quickly find out and can rip this hack out.
