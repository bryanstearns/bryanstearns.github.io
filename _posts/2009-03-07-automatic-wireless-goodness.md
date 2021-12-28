---
published: true
title: Automatic wireless goodness
date: "2009-03-07 15:29:18 -0800"
category: Coding
---

I often work in coffeeshops and other places that provide free wireless networks.
Since anyone could sniff traffic sent over these networks, I've set up my own
virtual private network at home so that my traffic will be encrypted before it
leaves my laptop, then decrypted on a server at home and sent out from my home
network <!--more-->- this also gives me secure access to a couple of machines at
home that aren't otherwise accessible from the internet. I use OpenVPN for
this; it's open-source, it was relatively easy to set up on my Ubuntu server,
and there's good support for OpenVPN in the Network Manager included on my
laptop (also running Ubuntu).

This worked great for a while, but a few things bugged me:

- The VPN connection doesn't happen automatically - I had to remember to do it,
  and would sometimes forget;
- my favorite hangouts' wireless networks ask me to accept terms of service
  every time I use them, and that got annoying;
- and whenever the DHCP lease renews (which is every few minutes in some
  places), the DNS server configuration would be reset to point at the shop's
  DNS server instead of the one I run (so I'd lose the ability to refer to my
  home machines by name; it's also possible that the public DNS server is less
  secure than mine, so that's not good).

I set out to remedy these problems, and it turned out to not be too difficult;
I learned a bit about Network Manager in the process, too. Network Manager can
automatically run a script when it associates with a wireless network, so I
wrote <a href="http://gist.github.com/75475">this Python script</a>;
it solves the first two problems: it looks to see what network we associated
with, and if it's not my home network, it creates the VPN connection. First,
though, if it's one of the networks that requires a terms-of-service acceptance,
it accepts them and submits the form. (The latter mechanism is specific to the
<a href="http://www.personaltelco.net/">Portland Telco Project</a>
networks we have here in Portland, but you can probably figure out how to customize
it to your own networks - if not, leave a comment.)

The third problem, where DHCP renewal clobbers DNS settings, seems to be known
but unfixed: here's <a href="https://bugs.launchpad.net/ubuntu/+source/dhcp3/+bug/90681">a
bug about it</a>. The person who reported the bug posted a workaround for this
problem. I'm not sure it's the right change for everyone, but I'm happy with it
in my case: it's a one-line addition to `/sbin/dhclient-script`; insert
this line just after the start of the `make_resolve_conf` function
that's first in that file:

<!-- prettier-ignore-start -->
{% highlight bash %}
    [ "$reason" = "RENEW" ] && return<br />
{% endhighlight %}
<!-- prettier-ignore-end -->

This shortcuts the function that would be overwriting the DNS settings to do
nothing if we're renewing the DHCP settings. (Admittedly, if the DNS server
addresses changed, I wouldn't know about it, but my home DNS server's address
hasn't changed in a while, and I wasn't in a coffeeshop when it did.)

With these mechanisms in place, I can open my laptop and see Network Manager's
progress by looking at its icon in the menu bar: I see it associate with a
network and go through the VPN connection process, without me having to do anything. Perfect.

[Update: Almost perfect: in cleaning up the script for posting, I broke it &mdash; I've fixed it.]
