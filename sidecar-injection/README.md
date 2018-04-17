## Environment specific sidecar injection
This example demonstrates the ability to inject a sidecar in a specific environment. In `environments/default/main.jsonnet`, we define a sidecar, and and append it to the container list
of the nginx-deployment deployment. Since the sidecar is defined only in 
`environments/default/main.jsonnet`, this sidecar will only be present when generating the manifests
for the `default` environment.

```
local sidecar = {
  "name": "sidecar",
  "image": "mysidecar:latest",
};

base + {
  "nginx-deployment" +: {
    "spec" +: {
      "template" +: {
        "spec" +: {
          "containers" +: [sidecar],
        }
      }
    }
  },
}
```

To run this example, show the `default` environment which contains the sidecar, and `no-sidecar`
environment for the environment without the sidecar:
```
ks show default
ks show no-sidecar
```
