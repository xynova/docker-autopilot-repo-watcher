# Docker+Ansible auto-pilot git repo watcher

This project demonstrates how to leverage Ansible inside a container to orchestrate a mini continuous build of a nodejs+angular application ([stub-ng-site](https://github.com/xynova/stub-ng-site)).

The main idea is to cover a few concepts when working with Docker:
* Using one process per container and promote composability the Kubernetes way
* Using Ansible as a higher level paradigm to make orchestration tasks more readable.
* Demonstrate how small build and validation pipelines can be achieved without too many external pieces (starting small)


## How to run it

Clone the repo
```
git clone https://github.com/xynova/docker-autopilot-repo-watcher.git
cd docker-autopilot-repo-watcher
```
Go to the provision directory and start running the present scripts
```
cd provision

# build docker images 
sudo ./docker-infra/docker-tcp-socket.sh
sudo ./docker-infra/swapfile.sh
./docker-infra/build-ansible.sh
./docker-infra/build-confd.sh
./docker-infra/build-containerbuddy.sh
./docker-infra/build-nodejs-bower-gulp.sh

# run containers
./docker-containers/etcd.sh
./docker-containers/ansible-watch.sh

```

