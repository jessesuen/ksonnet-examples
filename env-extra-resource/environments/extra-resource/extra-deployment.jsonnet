{
  "apiVersion": "apps/v1beta2",
  "kind": "Deployment",
  "metadata": {
    "name": "nginx-deployment-2",
    "labels": {
      "app": "nginx"
    }
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