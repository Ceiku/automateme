## Getting Started

### Setup
The `.env` file for this project should contain the following 

```
TZ=Continent/Capitol

influx_psw=something_hard_to_guess
influx_usr=username

ad_psw=something_hard_to_guess_again
ad_usr=username

## Optional Settings ##
path_prefix=${pwd}

# usb_device=/dev/tty*

ad_token=!secret ad_token
```

On the first deployment the token from home assistant that appdaemon needs cannot be made, once you have started home assistant you can follow these steps to make a token, then in `appdaemon/secrets.yml` add the line:

`ad_token=yourtoken`

And if it does not register the change you can always restart with:

`docker restart appdaemon`

The usb devices is only required if you have some usb tool for either bluetooth, ZigBee or other protocols for your home automation, and requires us to uncomment the device section in the `home-assistant` service in the `docker-compose.yml`.

## Core Services

### Home-Assistant

Provides tools to interface with a range of proprietary protocols and hardware, it offers state logging among many other integrations, as an open source project it also aims to provide home automation as privately as we'd want. Most of the features of Home-Assistant is available over the web ui, and using jinja and yaml for automations only work for small projects and simple automations, there are many popular tools to extend the sophistication of automation logic:
- AppDaemon: provides a pythonic framework for writing automations with helper functions for HA
- Node-Red: A graph based programming language that is popular for automations

Once the deployment is done, visiting your [browser](localhost:8123) should get you ready to follow the instructions here.

Once you are done with those steps I recommend you to check out the HACS integration, since most of the configuration is done through a web ui it is accomodating to any level of user experience. Some other integrations I would recommend on a general basis:
- [Circadian Lighting](https://github.com/claytonjn/hass-circadian_lighting)
- [Average Sensor](https://github.com/Limych/ha-average)
- [browser_mod](https://github.com/thomasloven/hass-browser_mod)

There are a lot of others that are fairly general, but somewhat dependent on where you live etc, or more correctly, where the developer lives.

### AppDaemon
We need to build the image for this service, it comes with an example of adding extra pip packages for our python environment, the general tutorial here gets us started. You can run appdaemon only to use mine or other contributors apps, like these projects.

It also support webhooks that we can use for our dialogflow fulfillment server instead of the nodejs express `dialogflow` service, which keeps our project constrained to a single language and framework. 


## Other
**ESPHome**

If we already know some very basic yaml we can now code some microcontrollers and create our very own IoT devices, it is built to fit naturally with HA and schematical syntax is the same, we can easily read our sensor data, do some on board automation and take action, in just a few lines of configuration we have a fully functional device with wifi. This followes the example of constraining to one language and framework as above.

In my case I have wanted the miflora, or something close to the same, but the device costs way more than the plant I wanted it to monitor, and I also have a lot of plants.
You can read more about my espbloom here, while you can have the device built from schematics, just using the parts such as I did for my prototype here is more than enough with some cable management.

If you are used to Arduino or other microcontrollers you might be amazed at how little 'code' we end up writing, but there are some exceptions, and if we need to import a Arduino type library (C++) then follow these steps.

**Influx database**

This is two separate services, where influxdb is the database itself, and chronograf is an admin and query visualisation tool in a web ui.
While it is not critical, it is a powerful tool in the long run as it lets us engage with our own data over months and years, this can reveal trends and improve over time. Imagine if we have readings of temperature and humidity in each room, if it suddenly drops unusually quickly, even when trying to heat up more to compensate _the window might very well be open_ and we should be notified so we can close it. This is something that might otherwise have required a physical window sensor.

In addition HA has a historic record that is dumped ever so often to ensure it does not become slow, so to preserve our data beyond this point we need an external database, influx provides a time-series record base that works well for timestamped values like sensor readings.

**Grocy**

An erp system for the fridge, and more, I have used it in combination with the grocy integration and the grocy chores card for an easy overview of weekly chores, when it is marked as complete they are automatically distributed again.

