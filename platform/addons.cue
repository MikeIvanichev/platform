package holos

import ("encoding/json")


Addons: {
	"cilium": {
		path: "addons/cni/cilium"
		selector: {
			"cni": "cilium"
		}
    _clusterParameters: _
    _fleetParameters: _
    parameters: #CiliumParameters & {
      clusterName: _clusterParameters.name
      os: _clusterParameters.os
      meshed: _fleetParameters.meshed
    }
	}

  "cert-manager": {
    path: "addons/cert-manager"
    _fleetParameters: _
    parameters: #CertManagerParameters & {
      heighlyAvailable: _fleetParameters.prod
    }
  }
}

// === Render ===

for fleetName, fleet in Fleets {
  for clusterName, cluster in fleet.clusters {
    for addonName, rawAddon in Addons {
      let union = rawAddon.selector & cluster.parameters
      if union != _|_ {
        let addon = rawAddon & {
            _fleetParameters: fleet.parameters
            _clusterParameters: cluster.parameters
        }
			  Platform: Components: {
			  	"\(fleetName).\(clusterName).addons.\(addonName)": {
			  		name:     addonName
			  		path:     addon.path
			  		parameters: {
              params: json.Marshal(addon.parameters)
              output_base_dir: "\(fleetName)/\(clusterName)/addons"
            }
			  	}
			  }
      }
    }
  }
}
