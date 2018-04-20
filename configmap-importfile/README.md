## ConfigMap with Imported Files
This example builds on the [Parameterized ConfigMap](../configmap-parameterized/README.md) example 
and demonstrates how jsonnet can import a local file on disk as a string using the `importstr` instruction. The config data is defined in the files `components/nginx.conf` and `components/proxy.conf`. The configmap component, `components/nginx-configmap.jsonnet`, imports those files as strings and performs string formatting with parameter substitution.

NOTE: this example does not currently function due to: https://github.com/ksonnet/ksonnet/issues/461

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
```

To run this example, run:
```
ks show default
```
