package holos

Fleets: {
  "cloud_controller": {
    parameters: {
      name: "cloud-controller"
    }
    clusters: {
      "hetzner": {
        parameters: {
          data_region: "eu"
          host: "hetzner"
          os: "talos"
          cni: "cilium"
          name: "hetzner"
        }
      }
    }
  }
}
