# Nuclide Docker
This is a very simple container with a working Nuclide server and watchman support.

## Quick start
```bash
git clone --recurse-submodules git@github.com:techcrystal/nuclide-docker.git
cd nuclide-docker
sudo docker-compose up -d
```

## Running
First, reconfigure the root directory you want mapped to the container in the `docker-compose.yml` file, under the `volumes` section in the `nuclide-server` service.

Then, copy your public key to be used for authentication under this directory, and rename it to `public_key`. This file will be used as the `authorized_keys` file. If you could previously log in to the machine with a private key, you should be able to do the same without change. Alternatively, you may use a password based authentication by uncommenting the line that echoes `root:passwd` into `chpasswd`. **It is highly recommended that you use a more secure password.**

In case you need anything else to run on the server (an autoformatter, for example), simply install them in the Dockerfile. Most of the work should be done on the host machine, though.

Finally, with Docker and `docker-compose` properly installed, all one needs to do should be simply
```bash
$ sudo docker-compose up -d
```

In Nuclide's "Add Remote Folder" dialog, use the following configuration:
* Username: `root`
* Server: Your server's IP address
* Port: 2022
* Initial Directory: `/root/workspace`
* Authentication Method: Private key (or Password, depending on how you chose to set up authentication)
* Remote Server Command: `nuclide-start-server`
