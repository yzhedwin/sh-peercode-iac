output "peercode_config_map" {
  value = kubernetes_config_map.peercode_config.metadata[0].name
}
