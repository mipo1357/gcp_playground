# 構築手順

1. GCP コンソールからプロジェクトを作成する
2. terraform をインストールしておく
3. gcloud もインストールしておく
4. gcloud でログインしておく(デフォルト設定を使用する場合は credential が正しいかどうかチェック)
5. `gsutil mb -l asia gs://バケット名`
6. コンソールから container registory と cloud run の API を有効化
7. `terraform init -backend-config=./backend.conf`
8. `terraform apply -var-file=./terraform.tfvars` 実運用ではシークレットな変数などはシークレットマネージャーに。
