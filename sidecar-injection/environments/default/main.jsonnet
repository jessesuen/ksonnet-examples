local base = import "base.libsonnet";
local k = import "k.libsonnet";

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
