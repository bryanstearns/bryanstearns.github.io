---
published: true
title: Quicker WEBrick startup
date: '2010-09-01 08:45:49 -0700'
---
> Despite its popularity WEBrick has gained some notoriety since the code is
> completely undocumented.
>
> -- <a href="http://en.wikipedia.org/wiki/WEBrick" target="_blank">Wikipedia's WEBrick page</a>

WEBrick is the little web server in the Ruby standard library, and I've used it
several times when I've needed to embed a little server in a project. I noticed
a couple of problems in my latest little program: it took a few seconds to start
up, and always included a `TCPServer Error: Address already in use - bind(2)`
warning in its startup messages.<!--more-->

After watching this happen a few dozen times, I found solutions to both these
annoyances, and they're here in the hope that someone else will Google their
way here: just create your server object like this:

{% highlight ruby %}
# This fixes the slow startup
Socket.do_not_reverse_lookup = true

# Using :BindAddress to say "bind to all interfaces"
# fixes the address-in-use warning
server = HTTPServer.new(:Port => my_port_number,
                        :BindAddress => "0.0.0.0")
{% endhighlight %}
