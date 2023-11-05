// tfstateをどこに置くかの設定
terraform {
  backend "s3" {
    bucket = "nargok-tfstate"
    key    = "example/prod/app/foobar_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
