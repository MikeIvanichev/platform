package holos

_Fleets: {
  CloudController: #Fleet & {
    Clusters: Hetnzer: Parameters: {
      dataRegion: "eu"
      host: "hetzner"
      os: "talos"
      cni: "cilium"
    }
  }
}
