
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
  Namespace: "cert-manager"

  Chart: {
    name:    "cert-manager"
    version: "1.15.3"
    repository: {
      name: "jetstack"
      url:  "https://charts.jetstack.io"
    }
  }

  Values: {
    crds: enabled: params.enableCRDs
  }
}
