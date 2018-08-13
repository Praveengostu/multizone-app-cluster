module "ibm-cluster" {
  source = "modules/ibm-cluster"
  zone1                 = "${var.zone1}"
  machine_type          = "${var.machine_type}"
  zone1_private_vlan_id = "${var.zone1_private_vlan_id}"
  zone1_public_vlan_id  = "${var.zone1_public_vlan_id}"
  zone2                 = "${var.zone2}"
  zone2_private_vlan_id = "${var.zone2_private_vlan_id}"
  zone2_public_vlan_id  = "${var.zone2_public_vlan_id}"
}
