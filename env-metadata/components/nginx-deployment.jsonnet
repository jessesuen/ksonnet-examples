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
  },
  "spec": {
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
            "image": "nginx:1.7.9",
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