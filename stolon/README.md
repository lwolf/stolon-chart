# Stolon Helm Chart

## Prerequisites Details
* Kubernetes 1.5 (for `StatefulSets` support)
* PV support on the underlying infrastructure

## StatefulSet Details
* https://kubernetes.io/docs/concepts/abstractions/controllers/statefulsets/

## StatefulSet Caveats
* https://kubernetes.io/docs/concepts/abstractions/controllers/statefulsets/#limitations


## Chart dependencies
* etcd from http://storage.googleapis.com/kubernetes-charts-incubator


## Chart Details
This chart will do the following:

* Implemented a dynamically scalable Stolon-based PostgreSQL cluster using Kubernetes StatefulSetss

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ git clone https://github.com/lwolf/stolon-chart
$ cd stolon-chart
$ helm dep build
$ helm install --name my-release .
```

## Configuration

The following tables lists the configurable parameters of the helm chart and their default values.

| Parameter                               | Description                                  | Default                                                      |
| --------------------------------------- | -------------------------------------------- | ------------------------------------------------------------ |
| `image`                                 | `stolon` image repository                    | `sorintlab/stolon`                                           |
| `imageTag`                              | `stolon` image tag                           | `v0.7.0-pg9.6`                                               |
| `imagePullPolicy`                       | Image pull policy                            | `Always` if `imageTag` is `latest`, else `IfNotPresent`      |
| `clusterName`                           | Name of the cluster                          | `kube-stolon`                                                |
| `debug`                                 | Debug mode                                   | `false`                                                      |
| `store.backend`                         | Store backend to use (etcd/consul)           | `etcd`                                                       |
| `store.endpoints`                       | Store backend endpoints                      | `http://etcd-0:2379,http://etcd-1:2379,http://etcd-2:2379`   |
| `pgReplUsername`                        | Repl username                                | `repluser`                                                   |
| `pgReplPassword`                        | Repl password                                | random 40 characters                                         |
| `pgSuperuserName`                       | Postgres Superuser name                      | `stolon`                                                     |
| `pgSuperuserPassword`                   | Postgres Superuser password                  | random 40 characters                                         |
| `sentinel.replicas`                     | Sentinel number of replicas                  | `2`                                                          |
| `sentinel.antiAffinity.enabled`         | Enable anti-affinity for sentinel replicas   | `true`                                                       |
| `sentinel.antiAffinity.type`            | Anti-affinity type for sentinel              | `hard`                                                       |
| `sentinel.resources`                    | Sentinel resource requests/limit             | Memory: `256Mi`, CPU: `100m`                                 |
| `proxy.replicas`                        | Proxy number of replicas                     | `2`                                                          |
| `proxy.resources`                       | Proxy resource requests/limit                | Memory: `256Mi`, CPU: `100m`                                 |
| `proxy.antiAffinity.enabled`            | Enable anti-affinity for proxy replicas      | `true`                                                       |
| `proxy.antiAffinity.type`               | Anti-affinity type for proxy                 | `hard`                                                       |
| `proxy.serviceType`                     | Proxy service type                           | `nil`                                                        |
| `keeper.replicas`                       | Keeper number of replicas                    | `2`                                                          |
| `keeper.resources`                      | Keeper resource requests/limit               | Memory: `256Mi`, CPU: `100m`                                 |
| `keeper.antiAffinity.enabled`           | Enable anti-affinity for keeper replicas     | `true`                                                       |
| `keeper.antiAffinity.type`              | Anti-affinity type for keeper                | `hard`                                                       |
| `keeper.client_ssl.enabled`             | Enable ssl encryption                        | `false`                                                      |
| `keeper.client_ssl.certs_secret_name`   | The secret for server.crt and server.key     | `pg-cert-secret`                                             |
| `persistence.enabled`                   | Use a PVC to persist data                    | `false`                                                      |
| `persistence.storageClassName`          | Storage class name of backing PVC            | `standard`                                                   |
| `persistence.accessMode`                | Use volume as ReadOnly or ReadWrite          | `ReadWriteOnce`                                              |
| `persistence.size`                      | Size of data volume                          | `10Gi`                                                       |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml .
```

## Persistence

The chart mounts a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning.

## SSL
To enable encrypted traffic, create certificates according to these instructions: https://www.postgresql.org/docs/9.6/static/ssl-tcp.html
The secret should hold servert.crt and server.key are required, by that name. For your convenience a [script](/scripts/create_pg_secret.sh) is included to create the secret in the cluster.

The use of **Client Certificates** is not supported
