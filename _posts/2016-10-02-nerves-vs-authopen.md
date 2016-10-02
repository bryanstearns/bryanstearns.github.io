---
published: true
title: A Nerves tidbit
date: '2016-10-02 13:24:04 -0700'
---
I've been working on learning the Elixir programming language for the last several months, and after returning from ElixirConf a few weeks ago, I was inspired to try a small project with Nerves, a platform for building Elixir applications on small devices like the Raspberry Pi.

Nerves provides a toolchain for building on the Mac which results in it writing a bootable microSD card that I boot in the Pi to try out my code. There's a lot of complexity in what Nerves is doing for me, but one little bit (not Nerves' fault!) annoyed me: I had to enter my login password every few minutes when Nerves wanted to write to the microSD card.<!-- more -->

I just found a way around this. The build command I use, every time I want to make a change, is this (I've broken it onto multiple lines for clarity) --

```
(cd apps/project &&              # switch into my app
MIX_ENV=prod mix firmware &&     # build the disk image

(until [ -d /Volumes/BOOT ];     # wait for me to reinsert the card
 do sleep 1;
done) &&

sudo chmod go+rw /dev/rdisk2 &&  # Make the raw disk image writable

MIX_ENV=prod mix firmware.burn -d /dev/rdisk2 &&  # write to the SD card

sync &&                          # flush changes - I'm paranoid
sleep 1)
```

That `sudo chmod` command is the point of this post: without it, every time I did a new build, I had to enter my password, because Nerves invokes a tool called `fwup` to write the image, and `fwup` uses `authopen` to get authenticated access to the raw file. This permissions fix has to be done every time the microSD card is reinserted. (I've already set up my `/etc/sudoers` file to allow me to use `sudo` without entering my password each time.)
