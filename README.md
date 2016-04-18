# Ansible-in-Docker as auto-pilot orchestrator

### A bit of context
The current project shows an example of how we can run Ansible from within a container to orchestrate, monitor and keep desired state of a containerised work pipeline in a a truly auto-pilot spirit.

When compared to shell scripts (which tend to become less readable once passed certain level of complexity), Ansible stands as a very easy to learn framework that can be all mighty while still keeping infrastructure overhead to a bare minimum. 

Within this project, it surfaces in a Docker detached container that continuously runs a Playbook with the following set of responsibilities:
 
1. Monitor changes made to a Git repository branch and perform  rolling updates when new versions are found. 
3. Maintain the deployment in a healthy state eve, specially across server reboots.
4. Push notifications to a slack channel in order to report deployment progress or errors when encountered.
6. Glue all the moving parts together
5. Behave like a good citizen and clean up after every new deployment.


> **Note:** Talking to the docker Daemon sockets is a risky practice. When sharing hosts with multiple container workload, it is very important to impose restrictions on what those sockets can ask the daemon to do. Nevertheless, the general approach described in this project remains valid when dealing with more high-end platforms (like Kubernetes) that provide an APIs layer through which authentication and authorisation can be enforced. 


### What is happening under the hood


* The Ansible container continuously monitors a git repository node-app@([stub-ng-site](https://github.com/xynova/stub-ng-site))
* When change is found, it clones it to a work directory for that deployment and runs npm install, bower and gulp using short lived gulp-bower containers against it.
* It then creates a "Pause" that does nothing other than reserving an IP and a network namespace (Kubernetes way)
* Three more containers are then joined to the network namespace, one for the WebAp (nodejs), another one for its API (nodejs), and a third one (nginx) acting as a reverse proxy for the previous two.
* Finally container-buddy is joined to the network namespace to help taking care of service registration aspects against etcd.
* It wraps up by asking a host gateway container to reload its configuration and start routing traffic to the POD. 

> ** Note: ** There are indeed quite a lot of few moving pieces in play, many of which just relate to plumbing service discover, health checking and desired state. With a platform like Kubernetes, the majority of these aspects are already covered by the system allowing us spend more time on the service itself instead of focusing on all that has to be deployed around it to run it.


## How to run it

1) Clone the repo

``` shell
git clone https://github.com/xynova/docker-autopilot-repo-watcher.git
cd docker-autopilot-repo-watcher 
```

2) Create a tcp listener socket monitored by systemd and tail all docker logs to journald (Prepared for CoreOS)

``` shell
cd provision/docker-infra
sudo ./disable-local-etcd.sh
sudo ./docker-tcp-socket.sh
sudo ./docker-opts.sh
```
3) Add 4 Gb of swap to prevent any memory issues with small instance hosts (for example when executing gulp builds).

``` shell
cd provision/docker-infra
sudo ./swapfile.sh
```


4) Build the required docker images

``` shell
cd provision/docker-infra
./build-ansible.sh
./build-confd.sh
./build-containerbuddy.sh
./build-nodejs-bower-gulp.sh
./pull-other-images.sh
```

5) Run containers

``` shell
sudo ./docker-containers/etcd.sh
./docker-containers/ansible-watch.sh 

# You can monitor progress by executing a docker logs against the watcher container
docker logs -f ansible-watchrepo
```

Once a deployment has succeded, you should be able to `curl localhost` and see some Html markup.


