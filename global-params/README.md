## Global Parameters

Globals are a way to inject and make parameters available to be referenced in all components. To
define a global, add the variable to the `global` section in
[`components/params.libsonnet`](components/params.libsonnet). In the example below, `replicas` is a 
global with the default value of 1:

```
{
  global: {
    replicas: 1,
  },
  components: {
    'nginx-deployment': {
      image: "nginx:1.7.9",
    },
  },
}
```

Referencing a global is exactly the same as referencing a component parameter. In the
[`nginx-deployment`](components/nginx-deployment.jsonnet) component, the `replicas` global parameter,
is referenced in the same manner as the `image` component parameter:

```
local params = std.extVar("__ksonnet/params").components['nginx-deployment'];
{
  "apiVersion": "apps/v1beta2",
  "kind": "Deployment",
  "metadata": {
    "name": "nginx-deployment",
    "labels": {
      "app": "nginx"
    }
  },
  "spec": {
    "replicas": params.replicas,
    "selector": {
      "matchLabels": {
        "app": "nginx"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "nginx"
        }
      },
      "spec": {
        "containers": [
          {
            "name": "nginx",
            "image": params.image,
            "ports": [
              {
                "containerPort": 80
              }
            ]
          }
        ]
      }
    }
  }
}
```

To override a global in a specific an environment, define the new value in the `globals.libsonnet`
file for that environment. In this example, replicas is being overridden in the 
[`prod`](environments/prod/globals.libsonnet) environment:

```
{
  replicas: 10,
}
```

To run this example, compare the `default` environment to the `prod` environment:
```
ks show default
ks show prod
ks diff local:default local:prod
```