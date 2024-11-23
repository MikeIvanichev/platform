package holos

#Cluster: close({
	// Passed to each component that is intended for this cluster as "cluster.\(param):\(val)"
	parameters: #Parameters & {
		name:        string
		data_region: "eu" | "usa" | "apac"
		host:        "hetzner" | "aws"
		os:          "talos"
		cni:         "none" | "cilium"
	}
})

#Fleet: close({
	clusters: [clusterName=string]: #Cluster & {parameters: name: clusterName}
	// Maps to Core.Component.WriteTo for all components in this deployment
	componentWriteTo?: string
	parameters: #Parameters & {
		meshed: bool | *true
	}
})

Fleets: [string]: #Fleet

#Addon: close({
	path: string
	selector?: [string]: string
})

Addons: [string]: #Addon

#Parameters: [string]: _
