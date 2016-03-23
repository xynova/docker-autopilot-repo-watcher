# Docker+Ansible git-repo auto-pilot deplyoment pipeline 

The current project represents an example of how Ansible (running from within a container) can be used to simplify orchestration, monitoring and desired state of complex containerised work pipelines. 

In this case, the Ansible container uses a docker-tcp socket to talk to the host's docker Daemon to manage independent dockerized tasks and keep the promise of having only one process per container.

The main idea is to cover a few concepts when working with Docker:
* Using one process per container and promote composability the Kubernetes way
* Using Ansible as a higher level paradigm to make orchestration tasks more readable.
* Demonstrate how small build and validation pipelines can be achieved without too many external pieces (starting small)


1. monitores changes
2. deploys without disruption
3. keeps desired state
4. maintains notifications
5. does not collapse on restart

to orchestrate a mini continuous build of a nodejs+angular application ([stub-ng-site](https://github.com/xynova/stub-ng-site)).


## How to run it

Clone the repo
>    `` git clone https://github.com/xynova/docker-autopilot-repo-watcher.git ``
>    `` cd docker-autopilot-repo-watcher ``

Build the required docker images

``` shell
cd provision/docker-infra
sudo ./docker-tcp-socket.sh
```
Build the required docker images

``` shell
cd provision/docker-infra
sudo ./swapfile.sh
```


Build the required docker images

``` shell
cd provision/docker-infra
./build-ansible.sh
./build-confd.sh
./build-containerbuddy.sh
./build-nodejs-bower-gulp.sh
```

Run containers

``` shell
./docker-containers/etcd.sh
./docker-containers/ansible-watch.sh 
```

