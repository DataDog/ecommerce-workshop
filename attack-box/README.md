# Attack Box

This is an attack container for simulating an adversary attempting to hack our online store.

You can build the container with a:

```
$ docker build . -t attack-box
```

It will then pull Hydra and gobuster, and install them into the container. From there, you can bash into the container to use each of these tools:

```
$ docker container run -it attack-box bash
```

## TODO

* Add a leaked ssh key (see FIXME)
* Add an attacker's new authorized key (see FIXME)
* Add container command for an attack to docker-compose, or in here as a shell script hidden from the container in our `.dockerignore`