## Drop-in YAML with parameterization

Ksonnet supports native YAML components to be "dropped into" the components directory. This example
demonstrates the ability to drop in a K8s YAML file into the components directory, and
apply some parameterization.

In this example we have a normal Kubernetes deployment yaml in the `components` directory at
[`components/nginx-deployment.yaml`](components/nginx-deployment.yaml)

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
```

Next, create a params entry for it in the [`components/params.libsonnet`](components/params.libsonnet):

```
{
  global: {
  },
  components: {
    'nginx-deployment': {},
  },
}
```

Finally, in [`environments/default/params.libsonnet`](environments/default/params.libsonnet), we can
override the value of the replicas by applying an overlay patch, as follows:

```
local envParams = params + {
  components +: {
    'nginx-deployment' +: {
      spec +: {
        replicas: 10,
      },
    },
  },
};

```

To run this example, run:
```
ks show default
```
