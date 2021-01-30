provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "cluster" {
  source        = "cloudowski/minikube/aws"
  env_name      = var.env_name
  subnet_id     = element(data.aws_subnet_ids.default.ids[*], 1)
  vpc_id        = data.aws_vpc.default.id
  instance_type = "t3a.medium"
}

provider "kubernetes" {
  host                   = yamldecode(module.cluster.kubeconfig).clusters[0].cluster.server
  cluster_ca_certificate = base64decode(yamldecode(module.cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)
  client_certificate     = base64decode(yamldecode(module.cluster.kubeconfig).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.cluster.kubeconfig).users[0].user.client-key-data)
}
provider "helm" {
  kubernetes {
    host                   = yamldecode(module.cluster.kubeconfig).clusters[0].cluster.server
    cluster_ca_certificate = base64decode(yamldecode(module.cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)
    client_certificate     = base64decode(yamldecode(module.cluster.kubeconfig).users[0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(module.cluster.kubeconfig).users[0].user.client-key-data)
  }
}

output "host" { value = yamldecode(module.cluster.kubeconfig).clusters[0].cluster.server }
output "ca" { value = yamldecode(module.cluster.kubeconfig).clusters[0].cluster.certificate-authority-data }
output "cert" { value = yamldecode(module.cluster.kubeconfig).users[0].user.client-certificate-data }
output "key" { value = yamldecode(module.cluster.kubeconfig).users[0].user.client-key-data }
