package holos

// === Define Parameter Schema ===

params: #MetricsServerParameters

// === Build Plan ===

holos: Helm.BuildPlan

Helm: #Helm & {
  Namespace: "kube-system"

  Chart: {
    name:    "metrics-server"
    version: "3.12.1"
    repository: {
      name: "metrics-server"
      url:  "https://kubernetes-sigs.github.io/metrics-server/"
    }
  }
}

// === Enable HA Mode ===

if params.highlyAvailable {
  Helm: Values: {
    replicas: 2
  }
}
