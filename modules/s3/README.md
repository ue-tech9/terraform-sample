
### S3.tfファイル

| リソース名                               | 説明                                            |
|----------------------------------------|-------------------------------------------------|
| `aws_s3_bucket.image_bucket`           | 画像保存用のS3バケットを作成します。アクセス制御はプライベートです。  |
| `aws_s3_bucket_versioning.image_bucket_versioning` | 画像保存用のS3バケットにバージョニングを有効にします。            |
| `aws_s3_bucket.alb_log_bucket`         | ALBのログを保存するS3バケットを作成します。アクセス制御はプライベートです。  |
| `aws_s3_bucket_lifecycle_configuration.alb_log_bucket_lifecycle` | ALBログ保存用のS3バケットに対するライフサイクル設定を行います。365日後にオブジェクトを削除します。 |
| `aws_s3_bucket_server_side_encryption_configuration.sse_config` | 画像保存用のS3バケットにサーバーサイド暗号化（SSE）を設定します。AES256アルゴリズムを使用します。 |

### variables.tfファイル

| 変数名                   | 説明                           | 型      |
|--------------------------|--------------------------------|---------|
| `image_bucket_name`      | 画像保存用のS3バケット名        | string  |
| `alb_log_bucket_name`    | ALBログ保存用のS3バケット名    | string  |

### output.tfファイル

| 出力名                | 説明                          |
|-----------------------|-------------------------------|
| `image_bucket_arn`    | 画像保存用バケットのARN       |
| `alb_log_bucket_arn`  | ALBログ保存用バケットのARN    |
