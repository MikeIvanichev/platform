package holos
import ("encoding/json")


// === Parameters ===

_params_json: string | *"" @tag(holos_params, type=string)
_params: {}
if _params_json != "" {
	_params: json.Unmarshal(_params_json)
}

params: {}
for k, v in _params {
	params: (k): v
}


// === Build Plan ===

holos: Helm.BuildPlan

Helm: #Helm & {
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
    cluster: name: params.fleet.name + params.cluster.name
    ipam: mode: "kubernetes"
  }
}

// === Talos ===

if params.cluster.os == "talos" {
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
}

// === Meshed ===

if params.fleet.meshed {
  Helm: Values: {
    cni: exclusive: false
    socketLB: hostNamespaceOnly: true
  }
}

