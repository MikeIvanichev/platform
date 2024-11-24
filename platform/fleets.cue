package holos

Fleets: {
  "cloud_controller": {
    clusters: {
      "hetzner": {
        parameters: {
          data_region: "eu"
          host: "hetzner"
          os: "talos"
          cni: "cilium"
        }
      }
    }
  }

  "hetzner_workers": {
    parameters: {
      prod: true
    }
    clusters: {
      "fn-1": {
        parameters: {
          data_region: "eu"
          host: "hetzner"
          os: "talos"
          cni: "cilium"
        }
      }
    }
  }
}
