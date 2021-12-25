---
published: true
title: Fixing a little VPN annoyance
date: "2008-11-17 11:54:56 -0800"
---

I'm writing this in a coffee shop, and when I'm using a public wireless network,
I like to secure my network traffic using a virtual private network (VPN) that
I set up on my server at home. Without this, anyone else close by could spy on
what I'm doing (including seeing passwords I'm sending to badly-secured web
sites). Unfortunately, the connection appears to go bad after a short while,
and it took me weeks to spend the minute it took to find a fix.<!--more-->

Here's where things get a little buzzwordy: You might know that every computer
needs a way to translate domain names (like "selfamusementpark.com") into
network addresses (like "192.168.1.5"); the Domain Name System does this
(hence its catchy name, <a href="http://en.wikipedia.org/wiki/Domain_Name_System">DNS</a>).

When my computer wants to use a public network, it gets assigned a network
address by the wireless base station, using something called Dynamic Host
Configuration Protocol - <a href="http://en.wikipedia.org/wiki/Dhcp">DHCP</a>.
As part of this assignment, my computer also gets the address of a local DNS
server address to use for name lookups. When I open my VPN connection, my
computer automatically starts using my DNS server at home, to be able to look
up the names of computers at home that aren't on the public internet. (Yeah, I
know: it's weird that I leave the house to work on computers at home, huh?)

Here's the catch: periodically, the base station requires my computer to
"renew" its address, and when it does, my computer gets switched back to use
the coffee shop's DNS server (even though my VPN connection is still open).
This is annoying, and I finally decided to look for a fix.

I found one in <a href="https://bugs.launchpad.net/ubuntu/+source/dhcp3/+bug/90681">this
Ubuntu bug</a>. It's a one-line change to a system script that prevents the
DNS server switch if it's happening because of an address renewal.

(Finding this took 30 seconds because I picked good search words, and applying
the fix took 30 more because I understood what was going on at this level of the
system. I'm blogging this because someone less technical than me might have more
trouble with each!)
