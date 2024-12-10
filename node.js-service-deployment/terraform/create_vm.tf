resource "vsphere_virtual_machine" "test_vm" {
  name             = "test-node.js"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 4096
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.network_91.id
  }
  disk {
    label = "disk"
    size  = 300
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
        linux_options { # Linux 운영 체제의 사용자 정의와 관련
            host_name = "test-node"
            domain = "smrc.klab-a"
        }
        network_interface {
            ipv4_address = "10.10.91.4"
            ipv4_netmask = 24
      }
      ipv4_gateway = "10.10.91.1"
      dns_server_list = "10.10.92.201"
    }
  }
}