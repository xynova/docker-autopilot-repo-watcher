# Ansible-in-Docker as auto-pilot orchestrator

### A bit of context
The current project shows an example of how we can run Ansible from within a container to orchestrate, monitor and keep desired state of a containerised work pipeline in a a truly auto-pilot spirit.

When compared to shell scripts (which tend to become less readable once passed certain level of complexity), Ansible stands as a very easy to learn framework that can do all mighty things while keeping infrastructure overhead to a bare minimum. 

The main field player here is an Docker detached container that continuously runs an Ansible Playbook with the following set of responsibilities:
 
1. Monitor changes made to a Git repository branch and perform  rolling updates when new versions are found. 
3. Maintain the deployment in a healthy state even across server reboots.
4. Push notifications to a slack channel in order to report progress, success or failure if errors are encountered.
5. Be a healthy citizen and clean up after every new deployment.

> **Note:** Talking to the docker Daemon sockets is a risky practice. When sharing hosts with multiple container workload, it is very important to impose restrictions on what those sockets can ask the daemon to do. Nevertheless, the general approach described in this project remains valid when dealing with more high-end platforms (like Kubernetes) that provide an APIs layer through which authentication and authorisation can be enforced. 


### Components
The main 



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

