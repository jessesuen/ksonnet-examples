local base = import "base.libsonnet";
local k = import "k.libsonnet";

local extra = import "extra-deployment.jsonnet";

base + {
  "nginx-deployment-2" : extra,
}
