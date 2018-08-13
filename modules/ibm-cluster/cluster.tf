resource "ibm_container_cluster" "cluster" {
  name              = "${var.cluster_name}"
  datacenter        = "${var.zone1}"
  default_pool_size = 1
  hardware = "shared"
  machine_type      = "${var.machine_type}"
  public_vlan_id    = "${var.zone1_public_vlan_id}"
  private_vlan_id   = "${var.zone1_private_vlan_id}"
  region            = "${var.region}"
}

resource ibm_container_worker_pool_zone_attachment default_zone {
  cluster         = "${ibm_container_cluster.cluster.id}"
  worker_pool     = "default"
  zone            = "${var.zone2}"
  public_vlan_id  = "${var.zone2_public_vlan_id}"
  private_vlan_id = "${var.zone2_private_vlan_id}"
  region          = "${var.region}"
}

data "ibm_container_cluster_config" "export_config" {
    cluster_name_id = "${ibm_container_cluster.cluster.id}"
}

resource "null_resource" "deploy_app" {
  depends_on = ["ibm_container_cluster_config.export_config"]
  provisioner "local-exec" {
    command = <<EOF
        export KUBECONFIG="${data.ibm_container_cluster_config.export_config.config_file_path}"
        kubectl run hello-world-deployment --image=praveeng04/hello-world:latest
        kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
        kubectl describe service hello-world-service
        EOF
  }
}

data "ibm_container_cluster" "testacc_ds_cluster" {
    cluster_name_id = "${ibm_container_cluster.cluster.id}"
}

data "ibm_container_cluster_worker" "worker_0" {
    worker_id = "${data.ibm_container_cluster.testacc_ds_cluster.workers[0]}"
}

data "ibm_container_cluster_worker" "worker_1" {
    worker_id = "${data.ibm_container_cluster.testacc_ds_cluster.workers[1]}"
}

variable "region" {
  default = "eu-de"
}

variable "zone1" {}

variable "machine_type" {}

variable "zone1_private_vlan_id" {}

variable "zone1_public_vlan_id" {}

variable "cluster_name" {
  default = "my-cluster"
}

variable "worker_pool_name" {
  default = "worker_pool"
}

variable "zone2" {}

variable "zone2_private_vlan_id" {}

variable "zone2_public_vlan_id" {}

output "app_url_1" {
  value = "${data.ibm_container_cluster_worker.worker_0.public_ip}"
}

output "app_url_1" {
  value = "${data.ibm_container_cluster_worker.worker_1.public_ip}"
}
