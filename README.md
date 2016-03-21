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

