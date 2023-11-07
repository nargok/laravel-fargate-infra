/**
* terraform実行時に値を設定できる
* 1. コマンドライン引数で設定 terraform apply -var="name=foobar"
* 2. tfvarsファイルで設定 terraform apply -var-file="foobar.tfvars"
* 3. moduleの呼び出し元で設定
*/
variable "name" {
    type = string
}

variable "holding_count" {
    type = number
    default = 10
}