package holos

import ("encoding/json")


// hidden because parameters is not concrete.
_Addons: {
	"cilium": {
		path: "addons/cni/cilium"
		selector: {
			"cluster_cni": "cilium"
		}
	}
  "cert-manager": {
    path: "addons/cert-manager"
  }
}

// === Render ===

for fleetName, fleet in Fleets {
	for clusterName, cluster in fleet.clusters {
		for addonName, addon in _Addons {
			Platform: Components: {
        let FLEET = fleet
        let CLUSTER = cluster
        let params = {
          fleet: FLEET.parameters
          cluster: CLUSTER.parameters
        }

				"\(fleetName).\(clusterName).addons.\(addonName)": {
					name:     "\(fleetName).\(clusterName).addons.\(addonName)"
					path:     addon.path
					writeTo?: fleet.componentWriteTo
					parameters: holos_params: json.Marshal(params)
				}
			}
		}
	}
}
