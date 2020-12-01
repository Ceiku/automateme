---
title: "Getting Started"
layout: single
author_profile: true
toc: true
toc_label: "Table of content"
toc_icon: "cog"
---

This project is still undergoing alpha development, any experienced user can simply use the docker-compose stacks as is without much trouble.
{: .notice--danger}

For anyone who has tried using open source solutions, or to create small shortcuts in our digital lives may quickly notice that getting it to work was the easy part, it was keeping it working over time, making sure we lost no data, and got the data when we needed it that was hard, and time consuming; and it only grew worse as we try to combine multiple of these. The Automate Me project is intended to make self hosted projects easy to set up and expand, it is divided into three parts:
- infrastructure: backups, network and security 
- cloud: our data and services anywhere
- automation: IoT and contextual applications

The infrastructure stack takes care of most of the things that a cloud provider would do for us, if you want to host your own solutions privately and reliably this section is important, it does not need to be deployed pre-emptively and you can still test out other services or migrate to this project. If you are interested to read more about how this project was designed, and how to make the most of this, check out the Automate Me blog series. There we also go in depth on paradigms such as Ubiquitous Computing, how to game end of the line desktop games from our phones, and how to make computing fade into the background with contextual automations.

## Setup
While it is adviced to have general knowledge of docker and docker-compose with yaml, it is not required and following the steps in the readme setup should be sufficient.
If any terminology used in this document is unfamiliar visiting the blog should provide an explenation of how to interpret these, a general understanding of ubiquitous computing and different hardware and OS platforms are provided as well. Each stack has a `README.md` with instruction on how to fill out the `.env` file, it will contain some sensitive data and is therefore added to the gitignore, and you fork the project and edit safely.

The `init.sh` walks you through a few setup steps such as:
 - automatic updates of host
 - installing docker if not present
 - adding docker priveleges to current user
 - select and deploy stacks
 
It also provides one handy alias autome, that lets you supply stack names (selects all if none is provided) it will then run `docker-compose up -d --build --remove-orphans` selected stacks. It is important to note that these two helper scripts assume a debian flavour of linux, the current solution might need minor modifications to work on ARM architectures, look or request for the ARM branch for more information.

### Alternatively
Each stack is contained as an independed docker-compose, so you could move it anywhere you wanted, just provide the '.env' file inside that directory instead.

## Notable Services:

- Nextcloud as a cloud platform
- Home Assistant for automation
- Bareos for backups
- Code-server for a full Visual Studio IDE in the browser
- Plex, a netflix and spotify service for your private content.

Home-Assistant is an integral piece of our home automation, the project itself is so big that is has been moved into its own repository with extended documentation.


