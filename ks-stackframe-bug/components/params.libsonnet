{
  global: {
    // User-defined global parameters; accessible to all component and environments, Ex:
    // replicas: 4,
  },
  components: {
    // NOTE: the values here are the default values, used only in the e2e/qa environments.
    // The prod environment overrides these values in environments/prod/params.libsonnet
    "my-service": {
      sslCert: "arn:aws:acm:us-west-2:111111111111:certificate/11111111-11111-1111-1111-1111111111",
    },
  },
}
