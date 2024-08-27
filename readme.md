>
> DNSMASQ is a lightweight, easy-to-configure DNS forwarder and DHCP server designed to provide DNS and optionally
> DHCP services to a small-scale network. It's particularly well-suited for resource-constrained devices like routers and firewalls.
> <a href="https://docs.fedoraproject.org/en-US/fedora-server/administration/dnsmasq" target="_blank">[fedoraproject.org]</a>
>

<br>

This repository provides a container image, DNSMASQ, which is designed to serve as a DNS PROXY with one or more upstream DNS servers. In its default configuration, DNSMASQ starts in host network mode, which allows the container to bypass the virtualised network stack. This enables the container to use the network interfaces and IP addresses of the server directly, without the need for port mapping configuration.

The following tutorial was created by Norbert EHART (norbert@ehart.net) in 2024 under the CC-BY license and is based on a DEBIAN (x64) system.

## REQUIREMENT

In order to proceed with the installation process, it is necessary to have the following software components in place.

```text
sudo bash
```

```text
apt update; apt install -y apt-transport-https ca-certificates moreutils curl gnupg2 software-properties-common python3 python3-pip
```

```text
[ -e /usr/lib/python3.11/EXTERNALLY-MANAGED ] && rm /usr/lib/python3.11/EXTERNALLY-MANAGED
```

```text
update-alternatives --install /usr/bin/python python /usr/bin/python3 1
```

```text
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

```text
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" >/etc/apt/sources.list.d/docker.list
```

```text
apt update; apt install -y docker-ce
```

```text
exit
```

## INSTALLATION

It is essential that each command is executed with root privileges.

```text
sudo bash
```

The first step is the creation of the configuration directory.

```text
mkdir -p /usr/local/etc/compose/dnsmasq
```

The remaining commands must then be executed directly from this directory.

```text
cd /usr/local/etc/compose/dnsmasq
```

The next step is the creation of the compose.yml and env.conf files.

```text
curl -fsSL --url https://gitlab.ans.co.at/docker/dnsmasq/-/raw/main/compose.yml --output compose.yml
```

```text
curl -fsSL --url https://gitlab.ans.co.at/docker/dnsmasq/-/raw/main/env.conf --output env.conf
```

Subsequently, the env.conf file must be modified in accordance with your particular specifications.

```text
vi env.conf
```

Finally, the container can be initiated.

```text
ln -s env.conf .env
```

```text
docker compose up -d
```

It is now possible to exit the shell with root privileges.

```text
exit
```

## UPDATE

If you already have an existing `DNSMASQ` container running and wish to update the image to the latest version available on `https://gitlab.ans.co.at`, use the following commands.

```text
sudo bash
```

```text
cd /usr/local/etc/compose/dnsmasq
```

```text
docker compose down
```

```text
eval $(cat env.conf | grep "DNSMASQ_" | sed -e '/^#/d' | sed -e '/^$/d'  |sed -e 's/ = /=/g')
```

```text
tar -czvpf "/root/$DNSMASQ_CONTAINER_NAME=.$(date +%s).tar" --absolute-names "$PWD"
```

```text
docker compose pull
```

```text
docker compose up -d
```

```text
exit
``` 

## CONTRIBUTION

In order to work on the `DNSMASQ` project, it is first necessary to clone this repository.

```text
git pull git@gitlab.ans.co.at:docker/dnsmasq.git
```

```text
cd dnsmasq
```

The stable version of this project is located in the main branch. For development purposes, a new branch should be created. There is no specific naming convention for the development branches.

```text
git branch fix_issue_122
```

```text
git switch fix_issue_122
```

```text
git push --set-upstream origin fix_issue_122
```

It is now time to take action and implement changes.

```text
vi dockerfile

[...]

vi entrypoint.sh

[...]

vi compose.yml
vi env.conf
```

Performing a localized test after the modifications are completed is imperative.

```text
sudo bash
```

```text
docker build --no-cache --file "dockerfile" --tag "registry.ans.co.at/docker/dnsmasq/dnsmasq:latest" .
```

```text
ln -s env.conf .env
```

```text
docker compose up -d
```

```text
dig @localhost -p 5353 www.upc.at
```

```text
docker compose down
```

```text
docker system prune --all --force
```

```text
exit
```

Once the modifications have been implemented, they can be pushed back to the current development branch.

```text
git pull
```

```text
git add .
```

```text
git commit -a -m "."
```

```text
git push
```

Now, the development branch is no longer required and the main branch can be made available for use again.

```text
git switch main
```

Once the development process is finished, the development branch must be merged into the main branch, and then deleted. After merging a development branch into the main branch, a new tag associated with the build date must be created. The build date must follow the format `YYYYMMDDXX`. The tag is also used to initiate a pipeline that generates the docker image in the container registry along with a new release.

```text
git tag -a 2024012100 -m ""
```

```text
git push --tags
```
