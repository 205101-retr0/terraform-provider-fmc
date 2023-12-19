terraform {
  required_providers {
    fmc = {
      source = "CiscoDevNet/fmc"
      # version = "0.1.1"
    }
  }
}

provider "fmc" {
  fmc_username = var.fmc_username
  fmc_password = var.fmc_password
  fmc_host = var.fmc_host
  fmc_insecure_skip_verify = var.fmc_insecure_skip_verify
}

data "fmc_devices" "device" {
    name = "FTD1"
}

# data "fmc_device_physical_interfaces" "device_physical_interface" {
#     device_id = data.fmc_devices.device.id
#     name = "TenGigabitEthernet0/1"
# }

# data "fmc_security_zones" "my_security_zone" {
#   name = "inside"
# }

# resource "fmc_device_physical_interfaces" "my_fmc_device_physical_interfaces" {
#     device_id = data.fmc_devices.device.id
#     physical_interface_id= data.fmc_device_physical_interfaces.device_physical_interface.id
#     name =   data.fmc_device_physical_interfaces.device_physical_interface.name
#     security_zone_id= data.fmc_security_zones.my_security_zone.id
#     if_name = "inside-1"
#     description = "testing phy int"
#     mtu =  1700
#     mode = "NONE"
#     ipv4_static_address = "192.168.1.11"
#     ipv4_static_netmask = 24
#     ipv4_dhcp_enabled = false
#     ipv4_dhcp_route_metric = 1
#     # ipv6_address = "2001:1234:5678:1234::"
#     # ipv6_prefix = 32
#     # ipv6_enforce_eui = false
# }


# output "existing_device" {
#   value = data.fmc_devices.device
# }

# output "existing_zone" {
#   value = data.fmc_security_zones.my_security_zone
# }
# output "physical_interface" {
#     depends_on = [ fmc_device_physical_interfaces.my_fmc_device_physical_interfaces ]
#     value = data.fmc_device_physical_interfaces.device_physical_interface
# }

data "fmc_device_physical_interfaces" "DeviceVar1PhysicalInterfaceVar9" {
  name = "Diagnostic0/0"
  device_id = data.fmc_devices.device.id
}

resource "fmc_device_physical_interfaces" "DeviceVar1PhysicalInterfaceVar9" {
  device_id = data.fmc_devices.device.id
  # 97428f1c-8e74-11ee-b1a3-c59d0f24f924
  enabled = true
  ipv6_enforce_eui = false
  mode = "NONE"
  mtu = "1500"
  name = "Diagnostic0/0"
  if_name = "test-diag"
  physical_interface_id = data.fmc_device_physical_interfaces.DeviceVar1PhysicalInterfaceVar9.id
  management_only = true
  # 0ECACC96-0320-0ed3-0000-004294969054
}

output "fmc_device_physical_interfaces_out" {
    value = fmc_device_physical_interfaces.DeviceVar1PhysicalInterfaceVar9
}