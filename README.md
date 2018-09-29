#Eclipse Mosquitto v1.4.15-r3 Docker Image

This image has been created slightly modifying the official one: https://github.com/eclipse/mosquitto

##Mount Points

Three mount points have been created in the image to be used for configuration, persistent storage and logs.
```
/mosquitto/config
/mosquitto/data
/mosquitto/log
```


##Configuration

When running the image, the default configuration values are used.
To use a custom configuration file, mount a **local** configuration file to `/mosquitto/config/mosquitto.conf`
```
docker run -it -p 1883:1883 -p 9001:9001 -v <path-to-configuration-file>:/mosquitto/config/mosquitto.conf tuxotron/mosquitto
```

Configuration can be changed to:

* persist data to `/mosquitto/data`
* log to `/mosquitto/log/mosquitto.log`

i.e. add the following to `mosquitto.conf`:
```
persistence true
persistence_location /mosquitto/data/

log_dest file /mosquitto/log/mosquitto.log
```

You also can create an user at runtime. To do so you have to provide the username and the password through the environment variables: MOSQUITTO_USER and MOSQUITTO_PASS respectively.

docker run -d --name mymosquitto -e MOSQUITTO_USER=myusername -e MOSQUITTO_PASS=mypass tuxotron/mosquitto

To verify the username has been created you can try to connect using the given credentials, or run the following command:
```
docker exec mymosquitto cat /mosquitto/config/pwfile
```
And you should see something like:

```
myusername:$6$y339lTm0XcMfJTwo$tdqku5kfPeIyI4O+v5iOfWP2WLPhIVnlJyPIf4go3G+0UdsZhKcz5Xx4LTct+h7IBebf1JjyDgHDcBrPZYVXlQ==
```
**This will also disable the anonymous access to your MQTT server**

**Note**: If a volume is used, the data will persist between containers.

##Build
Build the image:
```
docker build -t tuxotron/mosquitto .
```

##Run
Run a container using the new image:
```
docker run -it -p 1883:1883 -p 9001:9001 -v <path-to-configuration-file>:/mosquitto/config/mosquitto.conf -v /mosquitto/data -v /mosquitto/log tuxotron/mosquitto
```
:boom: if the mosquitto configuration (mosquitto.conf) was modified
to use non-default ports, the docker run command will need to be updated
to expose the ports that have been configured.
