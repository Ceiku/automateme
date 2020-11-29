---
permalink: /infrastructure/
title: "Infrastructure"
layout: single
toc: true
toc_label: "My Table of Contents"
toc_icon: "cog"
---

While an infrastructure is present for any service, self hosted or commercial, the latter often has a range of assurances most diy yourself guides either ommit or only explain in part. It is relatively easy to provide a new service, is another thing entirely to provide it reliably and robustly over time, this document will cover some strategies for data assurances, availability and security of all our hosted solutions collectively. When we pay a commercial cloud platform for 1TB, we might not think of how the transfer of data happens over an encrypted channel, the data is duplicated, often multiple times at different physical locations to prevent dataloss, lastly the service is available over any network, and has "no" downtime. 

To help us visualize this problem we will use some different deployment topographies from a single node, dual node, and larger distributions and we should understand the key differences between scaling up and out, and when we desire which. The infrastructure is independent from the personal device topology, and should be platform independent, some container format issues may occur on some ARM chipsets.

## Backing up

Anyone who has been unlucky enough to permanently loose precious memories or documents know the importance of backing up, but what 'safe enough'?
It boils down to how critical the data is for users or system functionality, loosing someones family pictures, or a business' intellectual property can be catastrophic, but loosing the OS system files can be easily replaced by a new install or a repair, so lets divide our data into three categories:
- system: data that only changes once the host itself updates OS or drivers etc.
- application data: the databases, keys and other configurations that represents our service in working condition
- user data: data that cannot be replaced or repaired upon loss

In the most simple use case, we would not need to care for application or system backups, in case of a critial failure we can always rebuild them with easy by repeating the setup, depending on the volume of user data, rebuilding the application and system might be very timeconsuming and the system would experience a long "downtime".


Caption; using only one node and a remote cloud service for the most importand user data, google cloud offers 15gb of free storage, so an encyrpted and compressed backup may provide closer to 20-23gb, for many users this is enough; I still use mine just to ensure my most precious files, and the encryption ensures that our storage provider would have no way on accessing those files. The "backup-remote.sh" can be used to upload and replace the old backup file on gdrive.

If we need more space for our backup, a secondary local node is preferred to a secondary disk on the same node; this is in case there should happen something that affects not just a single disk, but a single node to break down. The secondary node does not need to be as powerful as our primary node, its job is to delegate backups and recover, one problem with the deployment above is that if the system breaks down, we would need to manually restore the backup from disk. Our secondary node can act as an emergency partner, that sets the primary server into recovery mode and repairs; this would also work the other way around too, and the dual node system is as far out as most end consumers would need to scale their deployment. Using some form of remote storage as well we fulfill the 1-2-3 backup strategy of 3 layers of duplicity over 3 layers of location:

caption: Here we also see the nodes with more separation of responsibilities, to ensure a safe snapshot is saved in case of failure both nodes create backups, the same amount of user data is put aside on a commercial cloud for critical files.

### Bareos

To set up a backup solution that can be used platform independently, and can take proper dumps from databases we need more than simple file copying, this becomes even more important as we scale up across several nodes and services, bareos consist of three stacks that we will concern ourselves with, but it is recommended to get a decent understanding of main components. 
The storage stack is run on the device we want to store backups to, the client stack runs on the node we want to back up, the director holds a referance to the ip and id of the client and storage stacks, we usually only need one director to tell the client how and when to back up our data. The repository has some template client, storage and fileset descriptions that can be edited and copied into `project_root/bareos/config/director/bareos-dir.d` under the correct sub directory, this must be done on the node running the director stack. The next stage of development is to provide appropriate schedules for system, application and user-data, and to seperate them using the correct level of encryption and compression.

### Disk configurations

One way to assure duplicity is using RAID configurations, it can additionally increase read and write performance as we distribute over a set of disks. It is a viable solution where we need both very large storage volumes with as high read and write speeds as possible, with the most proficient setups requering both 4 and 5 'identical' disks it is to be considered a specialised solution seldom needed by end consumers. Using linux LVM (logic volume manager) may be the perfect tool for us instead, as we can connect all the old disks and drives we have and combine their storage easily into one logical volume, this is cheap and flexible.

## Availability

### Service uptime

As we have seen with the dual node topology we can use one node to restore the other, while this greatly reduces the downtime of our services we might be able to do better, since we are taking a backup to the secondary node, if it had enough overhead it could run the most essential services while restoring the primary, the data is already there, we just need to distribute the workload properly. The project is soon to migrate to kubernetes for easier distribution management.


### Network

Since we run our services containerized, we do not need to expose the ports to the host, let alone the gateway, this offers us a very granular level of control to where and how our services can be interacted with. By default each service expose relevant ports from the container to the host, this means that all our services will work on devices connected to the same local area network (LAN), usually our home network. This is a relatively safe option, but it does mean that we cannot access our services our their data from any other network, it is perfectly adequate for some sensitive services, but for our documents and file syncronisation we might want higher availability.

#### VPN

Virtual Private Networks is a conceptually easy and safe way to gain access to your devices wherever you are, as though you were still connected to the same LAN. While your real LAN consist of a full OSI stack from physical to application layer, a VPN is purely an application level network, providers such as ZeroTier offer us a centralized look-up-table that lets us resolve the address to a given node that is also registered on the same virtual network. As long as we keep the network id, and our account credential safe, publicly sharing your VPN IP has little implication on security, it is a great option for most users, but it lacks some usefull features; we cannot share links with any node not on registered to our VPN, so no casting content to a chromecast, no sharing a link to friends and colleagues, for the same reason many public webhook services cannot reach your instance. Another great thing about VPNS is that a single machine can be part of multiple networks, each can be isolated to provide a closed channel for a subset of devices.

For now zerotier is the only service that runs directly on the host, it is a feature currently under development.


#### Reverse proxy

This is no different than what most public web apps use as well, we forward the 443 (secure http(s)) port from our gateway to our node running the reverse proxy, we can then configure subdomains `subdomain.mydomain.org` or subfolders `mydomain.org/subfolder` that points to the other services we have. Since the communication over the unsafe open networks is secure, we often let the communication from our reverse proxy to our individual services remain on http without affecting our security, to increase general security the SWAG stack offers a set of options for elevated authentication.

In addition to SWAG, this stack by default comes with duckdns renewer that lets us get `domain.duckdns.org` for free that will point to our public IP, eg to our server.

It is pertinent to read the setup and configuration with care before enabling this with sensitive services as malicious users may try to compromise your node now that they can reach it, but as long as we follow these steps and have otherwise good password and social security habits we should be safe enough; we aren't hiding wikileaks or any high profile data.

#### Combining networks

As they all offer different degrees of availability and security, it might be a good option to use them all, but for different tasks, the services that I want to share, or that needs to be reached from public servers are available through the reverse proxy. More sensitive services such as backing up remotely etc is handled on isolated VPNs to ensure that neither node, transit or location of the data is exposed to unwanted agents.



