resource "aws_ecr_repository" "nginx" {
  name = "example-prod-foobar-nginx"

  tags = {
    Name = "example-prod-foobar-nginx"
  }
}

# ECRは保存されているイメージの容量に応じて料金がかかる。古いイメージを自動削除するための設定
resource "aws_ecr_lifecycle_policy" "nginx" {
  # JSONの記述方法は３つある
  # 1. ヒアドキュメント
  # 2. ファイルから読み込むfile(), templatefile()
  # 3. jsonencode()にjson文字列を渡す
  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Hold only 10 images, expire all others",
          "selection" : {
            "tagStatus" : "any",
            "countType" : "imageCountMoreThan",
            "countNumber" : 10
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
    }
  )

  repository = aws_ecr_repository.nginx.name
}
