---
title: "Getting Started"
layout: single
author_profile: true
toc: true
toc_label: "Table of content"
toc_icon: "cog"
---

While this documentation and the provides the design choices and discusses the implementation, the specific instrunctions for each service and stack is found in the project readmes, the automate me blog series discuss ubiquitous computing concepts, market trends and how implementing this paradigm as end users and enterprices can add features and reduce costs. To make the project easy to use, customize and expand the services are presented as docker containers in compose files, each docker file represents a stack of relevant services, the three main stacks are:
- Infrastructure: backups, network and security
- Cloud services: Everything from file and document managers to specialized tasks (Dev, creative content, gaming)
- Automation: Gathering and analyzing context to provide services without the need for user attention.

## Pre-requisites

While it is adviced to have general knowledge of docker and docker-compose with yaml, it is not required and following the steps in the readme setup should be sufficient.
To simplify this process, a `init.sh` script is provided to set up some automated updates, and to ensure we have docker and portainer installed; portainer gives us a web ui to control our container. If any terminology used in this document is unfamiliar visiting the blog should provide an explenation of how to interpret these, a general understanding of ubiquitous computing and different hardware and OS platforms are provided as well.

## Notable Services:

Nextcloud as a cloud platform
Home Assistant for automation
Bareos for backups
Code-server for a full Visual Studio IDE in the browser
Plex, a netflix and spotify service for your private content.

Home-Assistant is an integral piece of our home automation, the project itself is so big that is has been moved into its own repository with extended documentation.


