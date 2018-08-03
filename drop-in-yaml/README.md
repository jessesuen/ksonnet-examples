## Drop-in YAML with parameterization

This example demonstrates the ability to drop in a YAML file into the components directory, and
apply some parameterization.

In this example we have a normal Kubernetes deployment yaml `nginx-deployment.yaml` file placed in
the `components` directory:

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

Next we have an create a params entry for it in the `components/params.libsonnet`:

```
{
  global: {
  },
  components: {
    'nginx-deployment': {},
  },
}
```

Finally, in `environments/default/params.libsonnet`, we can override the value of the replicas by
constructing a overlay patch, as follows:

```
local envParams = params + {
  components +: {
    'nginx-deployment' +: {
      spec: {
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
