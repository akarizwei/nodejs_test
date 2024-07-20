resource "local_file" "secrets" {
  filename = "${path.module}/../applications/sample-application/secrets.tfvars"
  content  = templatefile("${path.module}/secrets.tmpl", {
    cluster_certificate_authority_data = module.eks.cluster_certificate_authority_data
    cluster_endpoint                 = module.eks.cluster_endpoint
    oidc_provider                    = module.eks.oidc_provider
    oidc_provider_arn                = module.eks.oidc_provider_arn
    vpc_id                           = module.vpc.vpc_id
  })
}