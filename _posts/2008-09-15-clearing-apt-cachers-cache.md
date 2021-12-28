---
published: true
title: Clearing apt-cacher's cache
date: "2008-09-15 11:25:21 -0700"
category: Coding
---

I frequently reinstall Ubuntu from scratch, so I've set up `apt-cacher` on my
fileserver to cache the packages I install - this not only reduces my impact
on the mirrors, but also speeds up my installs.<!--more-->

Occasionally, though, I see strange problems during installs: `apt-get install`
retrying the download of an apparently-cached package. I haven't figured out
what's wrong, and frequently I just want to get the reinstall going again. In
these situations, it seems optimal to just dump the cache and start over; I
haven't found clear documentation of how to do this, but in case it isn't
obvious, this works for me (my cache is in `/var/cache/apt-cacher`, and I run
it as www-data):

<!-- prettier-ignore-start -->
{% highlight bash %}
# Stop the service
sudo /etc/init.d/apt-cacher stop

# Move the old cache out of the way, so we can delete it
# in the background (it can take a while)
sudo mv /var/cache/apt-cacher /var/cache/apt-cacher.old
sudo rm -rf /var/cache/apt-cacher.old &

# Make the new cache hierarchy, and set its ownership properly
sudo mkdir -p /var/cache/apt-cacher/{headers,import,packages,private,temp}
sudo chown -R www-data:www-data /var/cache/apt-cacher

# Restart the service
sudo /etc/init.d/apt-cacher start
{% endhighlight %}
<!-- prettier-ignore-end -->

Update: I found
<a href="http://www.zyxware.com/articles/2008/07/27/how-to-fix-hash-sum-mismatch-and-size-mismatch-errors-from-apt-get-apt-cacher">this blog post</a>
helpful for manually removing troublesome packages from the cache.
