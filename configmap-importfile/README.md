## ConfigMap with Imported Files
This example builds on the [Parameterized ConfigMap](../configmap-parameterized/README.md) example 
and demonstrates how jsonnet can import a local file on disk as a string using the `importstr` instruction. The config data is defined in the files `components/nginx.conf` and `components/proxy.conf`. The configmap component, `components/nginx-configmap.jsonnet`, imports those files as strings and performs string formatting with parameter substitution.

`nginx.conf:`
```
{
...
  server { # php/fastcgi
    listen       %(port)s;
    server_name  %(serverNames)s;
    access_log   logs/domain1.access.log  main;
...
  }
}

```

`components/nginx-configmap.jsonnet:`
```
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
```

`ks show default`:
```
---
apiVersion: v1
data:
  nginx.conf: |-
...
      server { # php/fastcgi
        listen       80;
        server_name  domain1.com www.domain1.com;
        access_log   logs/domain1.access.log  main;
...
kind: ConfigMap
metadata:
  name: nginx-configmap
```


To run this example, run:
```
ks show default
```
