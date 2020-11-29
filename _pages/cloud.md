---
permalink: /cloud/
title: "Cloud Services"
layout: single
toc: true
toc_label: "Table of Contents"
toc_icon: "cog"
---

The services stacks presented here could be run individually, it is not a tutorial of basic functionality, but we do discuss some features that might not be apparent at first glance, and how they fit into our general idea of ubiquitous computing. As is discussed in the blog, the reasons for hosting our own solutions may be anything from extending commercial solution to flat out replacing them. While infrastructures detailed the backbone of all our services, here is where we offer our users functionalities.

## Nextcloud

Probably the most important stack in this group, it is a full blown cloud platform with all the features one would expect like calendars, file storage, document collaboration, there is even a nifty cookbook that can take links from most online recipe sites and extract the data into one common cookbook, it even has a built in timer; neato. Nextcloud is also scalable, and works well with the bareos backup manager, it comes with client apps for all OS and web view. 

## Plex

Media content and entertainemnt system that provides a netflix and spotify like interface to all your owned media, it can generate metadata like thumbnails, transcode and more to provide you with performance or quality on demand.


## Code-Server

Honestly, as a developer this is the single most important tool next to SSH I can imagine for any form of remote environment. It is the Visual Studio Code IDE in a web view, we can choose to host it ourselves, or use preconfigured ones as droplets or azure, it is fairly lightweight, and a simple single board computer is sufficient for code-server itself. I use an older intel nuc core i3 that also runs a range of other services, it barely complains at all, when I need to perform larger computations I scale out into cloud instances instead; read the blog post here to see why.

This blog post also discuss some of the key differences on developing with code-server in contrary to native vs code with remote SSH.


## Calibre

## Others

### Parsec

This would allow remote desktop that is specialized to reduce latency, out of the bunch I have tested both for remote play and LAN it clearly stood out. It does require the host to be Windows (which is usually the OS we game on), it might be preferred to use this device for only gaming, as running other background services may slow the system down.