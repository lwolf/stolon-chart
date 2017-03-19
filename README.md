# Helm chart to install Stolon (HA PostgreSQL cluster)

> Stolon is a cloud native PostgreSQL manager for PostgreSQL high availability.
> It's cloud native because it'll let you keep an high available PostgreSQL inside your containers
> (kubernetes integration) but also on every other kind of infrastructure
> (cloud IaaS, old style infrastructures etc...)

Chart is partially based on the statefullset example from the [stolon repo](https://github.com/sorintlab/stolon/tree/master/examples/kubernetes/statefulset)

Currently only etcd backend is supported.
Etcd is based on [chart from incubator](https://github.com/kubernetes/charts/tree/master/incubator/etcd) with updates to support 1.5 statefulset (PR pending).
After it will be merged, etcd will be removed from the source. 


## Requirements
* Kubernetes 1.5 (for `StatefulSets` support)
* PV support on the underlying infrastructure
* Helm 2.2.0 (for `conditions and flags` support)


## TODO:
- [x] automate initial stolon cluster creating
- [ ] Managed and standalone mode for etcd
- [ ] Add support for consul backend
- [ ] Conditional dependencies to be able to use either etcd or consul


## Known issues
* etcd from the incubator(and the copy here) has problems with **scale down** and re-joining fallen pods. [#685](https://github.com/kubernetes/charts/issues/685)

 