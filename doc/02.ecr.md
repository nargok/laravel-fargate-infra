## ECR
- 保存しているdocker imageの容量に応じて課金される
- 古いimageから自動削除する設定をするのが望ましい
	- ECR LifeCycle policyで設定ができる


- nginx用ECRを追加

- moduleを追加
	- 同じようなresourceの定義に便利な関数のようなもの
	- container imageの設定の塊

- moduleを追加したときは、必ず`terraform init`すること

- moduleを後から追加した
	- このままterraform applyできない
		- 同じ名前のECRリポジトリを作ってしまうから
	- 作成済のAWS resourceを新しく作ったmoduleのstateとしたい
	- そういうときに`terraform state mv`をする


```bash
# How to move state
terraform state mv <resource name move from> <resource name move to>
```

```bash
✗ terraform state mv aws_ecr_repository.nginx module.nginx.aws_ecr_repository.this
Move "aws_ecr_repository.nginx"
```

tfstateを現在のAWSリソースの状態に合わせて更新する
https://developer.hashicorp.com/terraform/tutorials/state/refresh

```bash
terrraform apply -refresh-only
```



- PHP用ECRを追加
	- moduleの追加になるので`terraform init`が必要


↓続き
- Local Value