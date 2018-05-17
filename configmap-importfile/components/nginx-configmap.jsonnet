local params = std.extVar("__ksonnet/params").components["nginx-configmap"];
local nginxConf = importstr "./nginx.conf";
local proxyConf = importstr "./proxy.conf";
{
  "kind": "ConfigMap",
  "apiVersion": "v1",
  "metadata": {
    "name": "nginx-configmap"
  },
  "data": {
    "nginx.conf": nginxConf % params,
    "proxy.conf": proxyConf % params,
  },
}