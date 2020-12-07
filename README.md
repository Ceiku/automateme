## Automate me

The Automate Me project is a supplement to the blog posts here, and has a range of tools to provide self hosted ubiquitous computing paradigms. All the services (except ZeroTier) is deployed using containerization with docker and docker-compose. The infrastructure stack provide data assurance, network tools and security considerations, cloud services contains work and entertainment services like code-server and nextcloud. Since ubiquitous computing uses contextual information to remove the need for users attention, the automation stack provides tools for home, computer and smart assistants.

### Pre-requisites

Since the deployment framework is docker containerisation (kubernetes for clustering under development) general knowledge of it, docker-compose and YAML is recommended if you want to alter any services or configuration, and while the images work fine on `amd64` architecture there are tags or images for `ARM` like raspberry pi. 

The compose file also specifies a default network called home that is will expect to find when you deploy the services, if you haven't already done that run this command:

`docker network create overlay home`


Beyond these considerations individual stacks might introduce additional requirements.

### Setup


Each stack also contains a `.env.example` that should be renamed to `.env` and filled in with the correct values, the `.env` file is ignored from the repository but you should still be carefull not unintentioally share it.

```
TZ=Continent/Capital
database_usr=username
database_psw=something_hard_to_guess

## Optional settings
# Current folder, assumed as default
path_prefix=${pwd}

```
They each have a structure like this, the top fields should be replaced, usually paswords and usernames but also some optional setting that have default values. The path default is always the current directory, which is handy for quick deployments. Instructions are presented for each stack individually, once this is complete the stack can be deployed with:

`docker-compose up -d`

When inside that subdirectory, which can be run again when we change some of our configurations, and can be modified with two useful flags:
- `--build`: rebuilds the containers from the `Dockerfile`
- `--remove-orphan`: if we change names or become depricated, this will remove them

If we want to remove a service we can run:

`docker-compose down`

Which takes the whole stack down, both the `up` and `down` command can have any number of individual service names separated by space.

`docker-compose down nextcloud influx` would only take down these two services.


#### Guided initialisation

The `init.sh` walks you through a few setup steps such as:
 - automatic updates of host
 - installing docker if not present
 - adding docker priveleges to current user
 
It is still a pending feature that I have considered to generalize, in automation we find a lot of the same functionality that also synchronizes backup and other things together.

## Notable Services

- Nextcloud as a cloud platform
- Home Assistant for automation
- Bareos for platform independendent and distrubuted backups
- Code-server, a full Visual Studio IDE in the browser
- Linuxserver SWAG for SSL certificates and reverse proxy



