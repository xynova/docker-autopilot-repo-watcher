# Ansible-in-Docker as auto-pilot orchestrator

### A bit of context
The current project presents an example of how Ansible (running from within a container) can be used to simplify orchestration, monitoring and keeping desired state of complex containerised work pipelines in a a truly auto-pilot spirit. In this case, the Ansible container uses a docker-tcp socket to talk to the host's docker Daemon to combine independent dockerized tasks and keep the promise of having only one process per container.

Ansible in my opinion comes in as a very easy to learn and yet very powerful framework to organise infrastructure automation scripts. Shell code might be very sexy, but it becomes less and less readable once scripts get passed a certain level of complexity. 



> **Note:** Talking to the docker Daemon sockets is a risky practice. When sharing hosts with multiple container workload, it is very important to impose restrictions on what those sockets can ask the daemon to do. Nevertheless, the general approach described in this project remains valid when dealing with more high-end platforms (like Kubernetes) that provide an APIs layer through which authentication and authorisation can be enforced. 


### Components
The main 

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

