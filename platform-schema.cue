package holos

#Cluster: close({
  // Passed to each component that is intended for this cluster as "cluster.\(param):\(val)"
  parameters: #Parameters & {
    data_region: "eu" | "usa" | "apac"
    host: "hetzner" | "aws"
    os: "talos"
    cni: "none" | "cilium"
  } 
})

#Fleet: close({
    clusters: [string]: #Cluster
    // Maps to Core.Component.WriteTo for all components in this deployment
    componentWriteTo?: string 
    parameters: #Parameters & {
      meshed: bool | *true
    }
})

Fleets: [string]: #Fleet

#Addon: close({
  path: string
  schema: [string]: _
  selector?: [string]: string
  parameters: #Parameters
})


Addons: [string]: #Addon

#Parameters: [string]: _
