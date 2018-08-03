## Parse YAML with parameterization

This example demonstrates the ability to parse a normal K8s YAML file into a jsonnet object for
further customization using jsonnet. A `parseYaml` function is provided in ksonnet for conveniently
parsing a file to a list of jsonnet objects.

In this example we have a normal Kubernetes deployment yaml `nginx-deployment.yaml` file placed in
the [`components/imports`](components/imports) directory. This location is arbitrary, but should be
different than the components directory since otherwise ksonnet will treat it as a drop-in yaml.
Notice that the image has a placeholder value. This will be replaced in the component jsonnet.

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
        image: PLACEHOLDER_VALUE
        ports:
        - containerPort: 80
```

In [`params.libsonnet`](components/params.libsonnet), expose `image` as a parameter to the
`nginx-deployment` component:
```
{
  global: {
  },
  components: {
    'nginx-deployment': {
      image: 'nginx:1.7.9',
    },
  },
}
```

Finally, create the `nginx-deployment` jsonnet component for the deployment at 
[`components/nginx-deployment.jsonnet`](components/nginx-deployment.jsonnet).
The code below will parse the YAML into a jsonnet object. Then replace the container list with
a list containing our parameterized image:

```
local params = std.extVar("__ksonnet/params").components['nginx-deployment'];
local parseYaml = std.native("parseYaml");
local nginxDeployment = parseYaml(importstr 'imports/nginx-deployment.yaml')[0];

nginxDeployment + {
  spec +: {
    template +: {
      spec +: {
        containers : [
          nginxDeployment.spec.template.spec.containers[0] + { image: params.image },
        ],
      },
    },
  },
}
```

To run this example, run:
```
ks show default
```
