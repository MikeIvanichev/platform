package holos

// === Register Addon ===

_Addons: {
  "cilium": {
    Path: "addons/cni/cilium/chart.cue"
    Selector: {
      "cluster.cni": "cilium"
    }
  }
}

// === Build Plan ===

holos: Helm.BuildPlan

Helm: #Helm & {
  Name:      "cilium"
  Namespace: "kube-system"

  Chart: {
    name:    "cilium"
    version: "1.16.4"
    repository: {
      name: "cilium"
      url:  "https://helm.cilium.io/"
    }
  }

  Values: {
    installCRDs: true
    kubeProxyReplacement: true
    operator: replicas: 1
    cluster: name: tags.name
    ipam: mode: "kubernetes"
  }
}

// === Tags / Parameters ===

let tags = {
  os: string @tag(cluster_os, type=string)
  name: string @tag(cluster_name, type=string)
  meshed: bool @tag(fleet_meshed, type=bool)
}

// === Talos ===

if tags.os == "talos" {
  Helm: Values: {
    k8sServiceHost: "localhost"
    k8sServicePort: 7445
    securityContext: {
      capabilities: {
        ciliumAgent: [
          "CHOWN",
          "KILL", 
          "NET_ADMIN", 
          "NET_RAW", 
          "IPC_LOCK", 
          "SYS_ADMIN", 
          "SYS_RESOURCE", 
          "DAC_OVERRIDE", 
          "FOWNER", 
          "SETGID", 
          "SETUID"
        ]
        cleanCiliumState: [
          "NET_ADMIN", 
          "SYS_ADMIN", 
          "SYS_RESOURCE"
        ]
      }
    }
    cgroup: {
      hostRoot: "/sys/fs/cgroup"
      autoMount: enabled: false
    }
}

// === Meshed ===

if tags.meshed {
  Helm: Values: {
    cni: exclusive: false
    socketLB: hostNamespaceOnly: true
  }
}

