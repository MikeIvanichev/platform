package holos

import "github.com/holos-run/holos/api/author/v1alpha5:author"

#Deployment: close({
  Components: [string]: #DeploymentComponent
  //Clusters?: [string]
})

#DeploymentComponent: close({
  Path: string
  Parameters?: [string]: string
})

#Cluster: close({
  // Passed to each component that is intended for this cluster as "cluster.\(param):\(val)"
  Parameters: [string]: string & {
    dataRegion: "eu" | "usa" | "apac"
    host: "hetzner" | "aws"
    os: "talos"
    cni: "none" | "cilium"
  } 
})

#Fleet: close({
    Clusters: [string]: #Cluster
    Deployments: [string]: #Deployment 
    // Maps to Core.Component.WriteTo for all components in this deployment
    ComponentWriteTo?: string 
    Parameters?: [string]: string & {
      "meshed": bool | *true
    }
})

_Fleets: [string]: #Fleet

#Addon: close({
  Path: string
  Selector?: [string]: string
  Parameters?: [string]: string
})

_Addons: [string]: #Addon

// === === ===

#ComponentConfig: author.#ComponentConfig & {
	Name:      _Tags.component.name
	Path:      _Tags.component.path
	Resources: #Resources
}

// https://holos.run/docs/api/author/v1alpha5/#Kubernetes
#Kubernetes: close({
	#ComponentConfig
	author.#Kubernetes
})

// https://holos.run/docs/api/author/v1alpha5/#Kustomize
#Kustomize: close({
	#ComponentConfig
	author.#Kustomize
})

// https://holos.run/docs/api/author/v1alpha5/#Helm
#Helm: close({
	#ComponentConfig
	author.#Helm
})
