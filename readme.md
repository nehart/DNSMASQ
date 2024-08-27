> 
> DNSMASQ is a lightweight, easy-to-configure DNS forwarder and DHCP server designed to provide DNS and optionally
> DHCP services to a small-scale network. It's particularly well-suited for resource-constrained devices like routers and firewalls.
> <a href="https://docs.fedoraproject.org/en-US/fedora-server/administration/dnsmasq" target="_blank">[fedoraproject.org]</a>
> 

<br>

#### INSTALLATION

...TBC...

#### UPDATE

...TBC...

#### CONTRIBUTION

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
docker build --no-cache --file dockerfile --tag registry.ans.co.at/docker/wingetty/wingetty:latest .
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
docker system prune -a
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
