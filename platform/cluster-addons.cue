package holos

for fleetName, fleet in _Fleets {
  for clusterName, cluster in fleet.Clusters{
    for addonName, addon in _Addons {
      _Platfrom: Components: {
        "\(fleetName).\(clusterName).addon.\(addonName)": {
          Path: addon.Path
          WriteTo: fleet.ComponentWriteTo
          Parameters: fleet.Parameters & cluster.Parameters & addon.Parameters
        }
      }
    }
  }
}
