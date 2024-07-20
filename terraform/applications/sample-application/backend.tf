terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "app-state"
    bucket  = "ops-env-infra"
  }
}
