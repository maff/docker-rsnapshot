# `docker-rsnapshot`

An image providing `rsnapshot` based on `debian:stable`.

## Usage

By default, the image expects 2 volumes `/source` and `/target` to be mounted. The default setup backs up `/source` to `/target` with the following config:

```
#########################################
#     BACKUP LEVELS / INTERVALS         #
# Must be unique and in ascending order #
# e.g. alpha, beta, gamma, etc.         #
#########################################
retain	hourly	4
retain	daily	7
retain	weekly	4
retain	monthly	12

###########################
# SNAPSHOT ROOT DIRECTORY #
###########################
snapshot_root	/target/

###############################
### BACKUP POINTS / SCRIPTS ###
###############################
backup	/source/	./
```

You can run `rsnapshot` with the default settings like this:

```shell
# use any of the levels configured in backup intervals
$ docker run -it --rm \
  -v /path/to/source:/source \
  -v /path/to/target:/target \
  rsnapshot hourly
```


## Customizing the configuration

If the default config does not suit your needs you can provide a custom config by mounting a `/config` volume containing a custom `rsnapshot.conf`.

To avoid having to maintain a whole config file, a default config file containing Debian's defaults is found in `/etc/rsnapshot-common.conf` and can be included from your custom config file:

```
# Include default config
include_conf	/etc/rsnapshot-common.conf


###########################
# SNAPSHOT ROOT DIRECTORY #
###########################
#
# All snapshots will be stored under this root directory.
snapshot_root	/target/


#########################################
#     BACKUP LEVELS / INTERVALS         #
# Must be unique and in ascending order #
# e.g. alpha, beta, gamma, etc.         #
#########################################

retain	alpha	6
retain	beta	7
retain	gamma	4


###############################
### BACKUP POINTS / SCRIPTS ###
###############################

backup	/source/	./
```

If your custom file is found you should see `Using external configuration file...` when running the container.

```shell
$ docker run -it --rm \
  -v /path/to/source:/source \
  -v /path/to/target:/target \
  -v /path/to/config:/config:ro \
  rsnapshot alpha

Using external configuration file...
```

## Credits

Inspired by [`scandio/docker-rsnapshot`](https://bitbucket.org/scandio/docker-rsnapshot/).