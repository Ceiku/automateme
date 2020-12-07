## Core Services
## Nextcloud

A cloud platform with all the whistle and bells of its commercial rivals, file storage, document collaboration, there is even a nifty cookbook that can take links from most online recipe sites and extract the data into one common cookbook, that even has a built in timer, it has a good app market and a thriving community. 

On first setup you will be asked to set up a new admin user, use a strong password.
Underneath you will see the storage and database section, select mariadb and fill in:

"image"

Select if you want the recommended apps or not, then you're ready to go.
Nextcloud is also scalable to multiple instances, this support will come in the kubernetes release, it also works well with [bareos](https://nextcloud.com/blog/how-to-back-up-nextcloud-with-bareos/).

## Code-Server

Honestly, as a developer this is the single most important tool next to SSH I can imagine for any form of remote environment. It is the Visual Studio Code IDE in a web view, we can choose to host it ourselves, or use preconfigured ones as droplets or azure. It is fairly lightweight, and a simple single board computer is sufficient for code-server itself. I use an older intel nuc core i3 that also runs a range of other services, it barely complains at all, when I need to perform larger computations I scale out into cloud instances instead; read the blog post here to see why.

This blog post also discuss some of the key differences on developing with code-server in contrary to native vs code with remote SSH.

Before you deploy, it is recommended to read up on other authentication methods for your code-server is you want to make it available over a public IP or domain name.
{: .notice--warning}


## Other Servcies

A collection of software that enhance or replace common features such as content streaming, file conversions and remote gaming. These are not really discussed as part of the project, but are things that I often set up for family and friends.

### Plex

Media content and entertainemnt system that provides a netflix and spotify like interface to all your owned media, it can generate metadata like thumbnails, transcode and more to provide you with performance or quality on demand.


### Calibre

Ebook conversion and library management tool, if you have a lot of books or different devices this can make things much easier than simple file storage in a cloud (data folders can overlap)


### Parsec

This would allow remote desktop that is specialized to reduce latency, out of the bunch I have tested both for remote play and LAN it clearly stood out. It does require the host to be Windows (which is usually the OS we game on), it might be preferred to use this device for only gaming, as running other background services may slow the system down.
