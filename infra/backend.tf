terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "gllaw"

    workspaces {
      name = "terraform"
    }
  }
}