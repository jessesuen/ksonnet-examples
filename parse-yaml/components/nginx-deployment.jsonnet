local params = std.extVar("__ksonnet/params").components['nginx-deployment'];
local parseYaml = std.native("parseYaml");
local nginxDeployment = parseYaml(importstr 'imports/nginx-deployment.yaml')[0];

nginxDeployment + {
  spec +: {
    template +: {
      spec +: {
        containers : [
          nginxDeployment.spec.template.spec.containers[0] + { image: params.image },
        ],
      },
    },
  },
}
