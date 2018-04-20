local params = std.extVar("__ksonnet/params").components["nginx-configmap"];
{
  "kind": "ConfigMap",
  "apiVersion": "v1",
  "metadata": {
    "name": "nginx-configmap"
  },
  "data": {
    "nginx.conf": (importstr "./nginx.conf") % params,
    "proxy.conf": (importstr "./proxy.conf") % params,
  },
}