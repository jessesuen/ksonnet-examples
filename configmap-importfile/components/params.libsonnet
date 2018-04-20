{
  global: {
    // User-defined global parameters; accessible to all component and environments, Ex:
    // replicas: 4,
  },
  components: {
    "nginx-configmap": {
      "serverNames": "domain1.com www.domain1.com",
      "port": 80,
    },
  },
}
