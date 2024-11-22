package holos

import ("encoding/json")


// hidden because parameters is not concrete.
_Addons: {
	"cilium": {
		path:       "addons/cni/cilium"
		parameters: #CiliumParameters
		selector: {
			"cluster_cni": "cilium"
		}
	}
}

// === Render ===

for fleetName, fleet in Fleets {
	for clusterName, cluster in fleet.clusters {
		for addonName, addon in _Addons {
			Platform: Components: {
				"\(fleetName).\(clusterName).addons.\(addonName)": {
					let FLEET = fleet
					let CLUSTER = cluster
					_params: addon.parameters & {
						fleet: name:   fleetName
						fleet: meshed: FLEET.parameters.meshed
						cluster: name: clusterName
						cluster: os:   CLUSTER.parameters.os
					}
					name:     "\(fleetName).\(clusterName).addons.\(addonName)"
					path:     addon.path
					writeTo?: fleet.componentWriteTo
					parameters: holos_params: json.Marshal(_params)
				}
			}
		}
	}

}
