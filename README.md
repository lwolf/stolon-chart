# Helm chart to install Stolon (HA PostgreSQL cluster)

> Stolon is a cloud native PostgreSQL manager for PostgreSQL high availability.
> It's cloud native because it'll let you keep an high available PostgreSQL inside your containers
> (kubernetes integration) but also on every other kind of infrastructure
> (cloud IaaS, old style infrastructures etc...)

Chart is partially based on the statefullset example from the [stolon repo](https://github.com/sorintlab/stolon/tree/master/examples/kubernetes/statefulset)

Currently only etcd backend is tested and supported.
Etcd is based on [chart from incubator](https://github.com/kubernetes/charts/tree/master/incubator/etcd) with updates to support 1.5 statefulset (PR pending)
