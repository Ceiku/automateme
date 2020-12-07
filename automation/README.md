## Getting Started

The automation stack is actually divided into two, the core services presented in the `docker-compose.yml` file, and the extensions are present in `docker-compose.extend.yml`. 




## Core Services

### Home-Assistant

The most imporant service in this stack, it is the focal point of the remaining services here, it solves a very important problem in smart homes and automation; unifying the data from different devices, services over many protocols. While we are used to wireless being Wi-Fi, this is not the only wireless protocoll, ZigBee, Z-wave and bluetooth are a few other protocols that we need to work with, home-assistant has an integration for almost any piece of hardware or software protocol we'd need.

Though creating automations can be done either in the web-ui, YAML and jinja2, they have some limitations to flexibility and level of control, this project has moved the automation logic to AppDaemon and uses home-assistant to gather the states and relay commands. While it is not used by this project, people who prefer a graphical approach to encapsulating logic or coding might want to use Node-Red instead that has more flexibility than jinja2.

Once you have deployed the stack your home assistant service will be available at [localhost:8123](localhost:8123) on your host machine, use the IP address or equivalent if working remotely. Create your user and set your basic information, you can also follow their tutorial for more information.

Once you are done with those steps I recommend you to check out the [HACS](https://hacs.xyz/) integration, since most of the configuration is done through a web ui it is accomodating to any level of user experience. Some other integrations I would recommend on a general basis:
- [Circadian Lighting](https://github.com/claytonjn/hass-circadian_lighting)
- [Average Sensor](https://github.com/Limych/ha-average)
- [browser_mod](https://github.com/thomasloven/hass-browser_mod)

There are a lot of others that are fairly general, but somewhat dependent on where you live etc, or more correctly, where the developer lives; public transportation integrations are a good example of geographically dependent services. 

### AppDaemon

This is where we encapsulate our logic, it is a pythonic framework with a lot of utilites for writing automations with home-assistant and can work independently with webhooks or MQTT. Even if you wont use it for developing your own automations, there are a lot of apps that provide a range of features and automations not easily achieved otherwise that we can just copy and paste.

We need to build the image for this service on demand, this also allows us to extend our python environment by installing pip packages, see the `appdaemon/Dockerfile` for an example of this.

### Google Assistant

The google assistant uses the `dialogflow` framework where we can specify intents and conversational flow, once it has all the information required it is sent to our fulfillment server where we choose what to do. We can host our fulfillment server in three ways:
- Home-assistant: Simple and limited way to handle fulfillments
- AppDaemon: Let's use ad-apps to handle fulfillments
- Node Express: Node server that uses the same framework as DialogFlow

The first option is highly discouraged at the time of writing as it only support basic features, using AppDaemon webhooks allows us to keep the whole automation project in the same language (YAML is used for docker-compose, home-assistant etc), while the Node server is easier to follow with the google documentation. 

## Other
**ESPHome**
While I consider this a core service, it is only usefull if we want to create our own IoT devices, it uses a YAML syntax that matches home-assistant which makes interoperability, code maintenance and the learning curve better than many other frameworks. Even as a seasoned developer it is nice to build anything from a simple sensor to an automated garden with only a few lines of code. 

For personal use and even small businesses this is a great solution, but it does not support meshing which might become a problem when we scale out to hundreds of devices. But if you are used to Arduino or other microcontrollers you might be amazed at how little 'code' we end up writing, but there are some exceptions, and if we need to import a Arduino type library (C++) then follow these steps. Since we usually need to maintain this alone, code reusability and how succint it is gives it an edge.

**Influx database**

This is two separate services, where influxdb is the database itself, and chronograf is an admin and query visualisation tool in a web ui. While I think it serves a very important purpose, as home-assistant will purge it's records that are over two weeks old by default for the service not to become slow or unresponsive, and we lose all data older than this. While it is not critical, it is a powerful tool as it lets us engage with our own data over months and years, this can reveal trends and improve over time. Imagine if we have readings of temperature and humidity in each room, if it suddenly drops unusually quickly, even when trying to heat up more to compensate _the window might very well be open_ and we should be notified so we can close it. This is something that might otherwise have required a physical window sensor.


**Grocy**

An ERP system for the fridge and home, while it is non-essential it has some nice features such as tracking chores that also has an integration with home-assistant, when a user finishes their weekly chore etc grocy automatically delegates the coming chores.

Using it with home-assistant may need the `HACS` integration.

