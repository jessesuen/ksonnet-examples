## Environment Metadata

Ksonnet exposes limited metadata about the environment which are made available in a jsonnet
external variable `__ksonnet/environments`. Currently ksonnet exposes two variables:
* `env.namespace` - the application's namespace
* `env.server` - the Kubernetes API Server URL

```
local params = std.extVar("__ksonnet/params").components['nginx-deployment'];
local env = std.extVar("__ksonnet/environments");
{
  "apiVersion": "apps/v1beta2",
  "kind": "Deployment",
  "metadata": {
    "name": "nginx-deployment",
    "labels": {
      "app": "nginx"
    },
    "annotations": {
        "my-namespace": env.namespace,
        "my-cluster": env.server,
    },
...
```

To run this example, compare the `default` environment to the `prod` environment, and notice that
the annotations containing the namespace and server are different:
```
ks show default
ks show prod
ks diff local:default local:prod
```