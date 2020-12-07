## Automate me

The Automate Me project is a supplement to the blog posts here, and has a range of tools to provide self hosted ubiquitous computing paradigms. All the services (except ZeroTier) is deployed using containerization with docker and docker-compose. 

The _infrastructure stack_ provide data assurance, network tools and security considerations, the _cloud stack_ contains work and entertainment services like code-server and nextcloud. To complete our ubiquitous computing framework we use contextual information to remove the need for users attention, the _automation stack_ provides tools for smart home and assistants.

### Pre-requisites

Since the deployment framework is docker containerisation (kubernetes for clustering under development) general knowledge of it, docker-compose and YAML is recommended if you want to alter any services or configuration, and while the images work fine on `amd64` architecture there are tags or images for `ARM` like raspberry pi. 

The compose file also specifies a default network called home that is will expect to find when you deploy the services, if you haven't already done that run this command:

`docker network create overlay home`


Beyond these considerations individual stacks might introduce additional requirements.

### Setup
The project contains an `.env.example` file that must be renamed to `.env`, this file is sanitized (ignored from tracking) and can be filled with your own data, just be sure to not unintentionally share it otherwise.

The two first lines of the file is:

```
COMPOSE_PATH_SEPARATOR=:
COMPOSE_FILE=infrastructure/admin/docker-compose.yml:infrastructure/backup/docker-compose.yml:infrastructure/network/docker-compose.yml:cloud/nextcloud/docker-compose.yml:automation/docker-compose.yml
```

The `COMPOSE_FILE` is just the paths to the docker-compose files we want to use, the example file does not include the backup stacks, see the infrastructure documentation for more information on this. Some other commonly used variables are set there such as:

```
path_prefix=${pwd}
TZ=Europe/London
```

Each individual service may introduce new variables we need to set, most of these are usernames and passwords, sometimes we might need an API key or token and the instruction is presented in the relevant service documentation. This means that configuring our deployment and stack can be done unified through one file, alternatively the admin stack sets up Portainer for a web ui Docker administration tool.

Once we have filled in the `.env` file as we desire we can deploy the whole project with:

`docker-compose up -d`

Which can be run again when we change some of our configurations, and can also be modified with two useful flags:
- `--build`: rebuilds the containers from the `Dockerfile`
- `--remove-orphan`: if we change names or become depricated, this will remove them

If we want to remove a service we can run:

`docker-compose down`

Which takes the whole stack down, both the `up` and `down` command can have any number of individual service names separated by space.

`docker-compose down nextcloud influx` would only take down these two services.


## Notable Services

- Nextcloud as a cloud platform
- Home Assistant for automation
- Bareos for platform independendent and distrubuted backups
- Code-server, a full Visual Studio IDE in the browser
- Linuxserver SWAG for SSL certificates and reverse proxy



