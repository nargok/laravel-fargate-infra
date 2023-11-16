resource "aws_iam_user" "github" {
    name = "${local.name_prefix}-${local.service_name}-github"

    tags = {
        Name = "${local.name_prefix}-${local.service_name}-github"
    }
}

/**
* Deployに必要な権限を持つIAMロール
**/
resource "aws_iam_role" "deployer" {
    name = "${local.name_prefix}-${local.service_name}-deployer"

    /**
    * どのようなAWSリソースからAssumeRoleできるかを定義する
    **/
    assume_role_policy = jsonencode(
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "sts:AssumeRole",
                        "sts:TagSession" // Github Actionでセッションタグの受け渡しが行われるのでこれを指定する
                    ],
                    // 指定のIAMユーザーからAssumeRoleできるようにする
                    "Principal": {
                        "AWS": aws_iam_user.github.arn
                    }
                }
            ]
        }
    )

    tags = {
        Name = "${local.name_prefix}-${local.service_name}-deployer"
    }
  
}

// ECRにイメージをPUSHするためのIAMロール
// dataは、tfstateでは管理してないリソースを参照するための機能
data "aws_iam_policy" "ecr_power_user" {
    arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "role_deployer_policy_ecr_power_user" {
    role = aws_iam_role.deployer.name
    policy_arn = data.aws_iam_policy.ecr_power_user.arn
}