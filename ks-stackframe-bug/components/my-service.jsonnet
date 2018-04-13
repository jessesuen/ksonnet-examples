local params = std.extVar("__ksonnet/params").components["my-service"];
{
  "kind": "Service",
  "apiVersion": "v1",
  "metadata": {
    "name": "my-service",
    "annotations": {
      "service.beta.kubernetes.io/aws-load-balancer-ssl-ports": "443",
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "https",
      "service.beta.kubernetes.io/aws-load-balancer-ssl-cert": params.sslCert,
    }
  },
  "spec": {
    "selector": {
      "app": "my-service"
    },
    "ports": [
      {
        "name": "https",
        "port": 443,
        "protocol": "TCP"
      }
    ],
    "type": "LoadBalancer",
  }
}