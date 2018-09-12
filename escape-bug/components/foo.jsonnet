local params = std.extVar("__ksonnet/params").components["foo"];
{
  "kind": "ConfigMap",
  "apiVersion": "v1",
  "metadata": {
    "name": "foo"
  },
  "data": {
    "from-param": params.data,
    "from-literal": 'something "with" double-quotes',
  },
}