# Helm chart to install Stolon (HA PostgreSQL cluster)

> Stolon is a cloud native PostgreSQL manager for PostgreSQL high availability.
> It's cloud native because it'll let you keep an high available PostgreSQL inside your containers
> (kubernetes integration) but also on every other kind of infrastructure
> (cloud IaaS, old style infrastructures etc...)

Chart is partially based on the statefullset example from the [stolon repo](https://github.com/sorintlab/stolon)

> This chart was accepted to the official kubernetes/charts repository and could be installed from there as well, but **charts are not interchangeable**.
> https://github.com/helm/charts/tree/master/stable/stolon


## Requirements
* Kubernetes >1.5
* PV support on the underlying infrastructure
* Helm 2.2.0 (for `conditions and flags` support)


## TODO:
- [X] Automate initial stolon cluster creating
- [X] Do not manage etcd dependency, do not rely on etcd chart
- [ ] Add support for consul backend
- [X] Add support for kubernetes backend (experimental)
- [X] Add support for 1.6


## Support the project
If you want to support the project, you can do it using BeerPays

[![Beerpay](https://beerpay.io/lwolf/stolon-chart/badge.svg?style=beer-square)](https://beerpay.io/lwolf/stolon-chart)  [![Beerpay](https://beerpay.io/lwolf/stolon-chart/make-wish.svg?style=flat-square)](https://beerpay.io/lwolf/stolon-chart?focus=wish)
