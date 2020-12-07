---
permalink: /automation/
title: "Smarter Automations"
layout: single
author_profile: true
toc: true
toc_label: "Table of content"
toc_icon: "cog"
---
_"If infrastructure is the foundation of all our services and devices, then automation is what grows from them."_

Anything from automatic travel itiniraries, to automatic vacuuming, automations are the computations that free our attention from a tasks. 
With a large range of protocols and propritary software no two projects will be the same, but there are some core concepts that give us valuable contexts, in a very simplified way, automations require two components beside computational resource:

**Sensors:**
While we easily think of temperature or light sensors, a mail inbox, or achieving todays fitness goals can trigger events or change states, we collect all our sensors into Home-Assistant that works as a state reporter for our myriad of things and protocols.

**Actuators:**
At the end of any automation comes an action, an actuator is the machinery or code that we use, like a remote light-switch, or an automated email reply.

This project is still undergoing alpha development, any experienced user can simply use the docker-compose stacks as is without much trouble.
{: .notice--danger}

{% include_relative README.md %}