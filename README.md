# Automuteus Selfhost on GCP
## Description
TBA

## Requirements
- [tfenv](https://github.com/tfutils/tfenv) >= 2.1.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install?hl=ja) >= 326.0.0

## Preparation
1. Google Cloud のアカウントを作成します
2. Service Account (Role: Editor) を作成し、 `export GOOGLE_APPLICATION_CREDENTIALS={クレデンシャルのパス}`を実行します
3. `tfstate` 保存用に、下記の要件を満たす無料枠の GCS を手動で作成します
```
location type: Region
location: us-east1
default storage class: Standard
versioning: enabled
life cycle: delete, num_newer_versions = 5
```
## Usage
1. `tfenv install` を実行して、指定バージョンの terraform を取得します
2. `terraform init` を実行して、terraform を初期化します
3. `terraform apply` で、GCP 上のリソースを作成します
4. `terraform destroy` で、GCP 上のリソースを削除します