---
published: true
title: Rails script/performance/request needed a little help
date: "2008-08-29 10:29:34 -0700"
category: Coding
---

While following <a href="http://railscasts.com/episodes/98-request-profiling">another
great Ryan Bates Railscast</a>, I had a couple of problems on my Ubuntu 8.04
development machine:

Rails 2.1.0's ActionController wants version 0.6.1 or later of the ruby-prof
gem, but the usual gem repositories only have 0.6.0 now. I found suggestions
to install <a href="http://github.com/jeremy/ruby-prof">Jeremy Kemper's fork
on Github</a>, but though I'd <a href="http://github.com/blog/97-github-loves-rubygems-1-2">added
GitHub as a gem source</a>, installing jeremy-ruby-prof didn't work because
that installed his version with that name, which didn't help ActionController.
What worked was:

{% highlight bash %}
sudo gem uninstall jeremy-ruby-prof # be sure to uninstall old attempts!
git clone git://github.com/jeremy/ruby-prof.git
cd ruby-prof
rake gem
sudo gem install pkg/ruby-prof-0.6.1.gem
{% endhighlight %}

Then, script/performance/request ran, but generated several strange error
messages instead of producing results:

```
Couldnt get a file descriptor referring to the console
Could not get a file descriptor referring to the console
Couldnt get a file descriptor referring to the console
Could not get a file descriptor referring to the console
```

This turned out to be because `script/performance/request` wants to use `open`
to open its output files (a text file and an HTML document), but on Ubuntu,
`/usr/bin/open` is a link to `/usr/bin/openvt`, which didn't do what we want
(and generated those error messages). I'm not sure what else uses `open`,
but this did the right thing: it lets Firefox open the files:

{% highlight bash %}
sudo ln -sf /usr/bin/firefox /usr/bin/open
{% endhighlight %}
