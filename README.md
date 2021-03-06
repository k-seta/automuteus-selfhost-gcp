# Selfhost on GCP
## Description
GCP の無料枠内での色々なサーバーのセルフホスティングを Terraform + GitHub Actions で実現します。

以下のサーバーをセルフホストできます。
- AutoMuteUs
- factorio headless

## Usage
1. GitHub の `Actions > terraform ci > Run workflow` を順次クリックします。
2. `terraform command` に `plan` を入力して `Run workflow` を実行すると GCP に作成するリソースを確認できます。
3. `terraform command` に `apply` を入力して `Run workflow` を実行すると GCP に AutoMuteUs のためのリソースを作成します。
4. `terraform command` に `destroy` を入力して `Run workflow` を実行すると GCP に作成したリソースを削除します。

## Development
### General
1. Google Cloud のアカウントを作成します。
2. Service Account (Role: Editor) を作成し、 取得した `credentials.json` に記載された json を GitHub の `Settings > Secrets` に `GOOGLE_CREDENTIALS` として登録します。
3. `tfstate` 保存用に、下記の要件を満たす無料枠の GCS を手動で作成します。
```
location type: Region
location: us-east1
default storage class: Standard
versioning: enabled
life cycle: delete, num_newer_versions = 5
```
4. [main.tf の project id](https://github.com/k-seta/automuteus-selfhost-gcp/blob/master/main.tf#L2) を自分のプロジェクトの値に変えて commit & push します。
5. [main.tf の backend bucket の名前](https://github.com/k-seta/automuteus-selfhost-gcp/blob/master/main.tf#L9)を 5. で作った値に変えて commit & push します。
6. おめでとうございます。

### For AutoMuteUs
1. Discord Developer Portal で AutoMuteUs をセルフホスティングするための Bot を作成し、Bot の Token を GitHub の `Settings > Secrets` に `TF_VAR_DISCORD_BOT_TOKEN` として登録します。

### For factorio
1. factorio の Mods の DL 用 URL を GitHub の `Settings > Secrets` に `TF_VAR_FACTORIO_MODS_URL` として登録します。
