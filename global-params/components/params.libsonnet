{
  global: {
    replicas: 1,
  },
  components: {
    'nginx-deployment': {
      image: "nginx:1.7.9",
    },
  },
}
