---
published: true
title: Android AIDL regeneration
date: "2008-09-30 12:37:52 -0700"
category: Coding
---

I'm working on a couple of Android projects; one has an Android IDL file
(.aidl) for a service, and for some reason, the development environment didn't
automatically generate the corresponding .java file from it. I wasn't able to
figure out what caused this, and recreating the .aidl file didn't fool the IDE
into doing it, nor was I able to find a solution to this with the usual
Googling.<!--more-->

I did find that right-clicking the project in the hierarchy and choosing
"Android Tools" -> "Fix Project Properties" fixed this. Subsequent changes to
the .aidl file automatically regenerated the .java file, too, so that's nice.
