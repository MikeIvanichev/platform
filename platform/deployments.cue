package holos

for fleetName, fleet in _Fleets {
  for clusterName, cluster in fleet.Clusters{
    for deploymentName, deployment in fleet.Deployments {
      for componentName, component in deployment {
        for k, v in component.ClusterSelector {
          if cluster.Parameters[k] != _|_ {
            if cluster.Parameters[k] == v {
              _Platform: Components: {
                "\(fleetName).\(clusterName).\(deploymentName).\(componentName)": {
                  Path: component.Path
                  WriteTo: fleet.ComponentWriteTo
                  Parameters: fleet.Parameters & cluster.Parameters & component.Parameters
                }
              }
            }
          }
        }
      }
    }
  }
}
