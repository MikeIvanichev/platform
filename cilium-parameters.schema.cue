package holos

// the cilium addon should only refer to these parameters.  This schema
// definition defines the interface between the platform and the addon.
#CiliumParameters: {
	fleet: name:   string
	fleet: meshed: bool
	cluster: name: string
	cluster: os:   string
}
