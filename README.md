# TerraformでAWSの構成を構築

下記の構築の手順はブログにまとめました。

[TerraformでAWSのリソースを一通り構築](https://zenn.dev/uepon/articles/37d06dd43e701c)

---
## 全体方針

### 構成図

![スクリーンショット 2023-10-31 0 26 24](https://github.com/ue-tech9/terraform/assets/55121867/af2f85ce-d800-4d1c-9423-9f9de5cdb860)



## ディレクトリ構成

```bash
.
├── env  # 環境ごとの設定を格納するディレクトリ
│   ├── development  # 開発環境用のディレクトリ
│   │   ├── main.tf  # 開発環境のメイン設定ファイル
│   │   ├── backend.tf  # 開発環境のバックエンド設定ファイル
│   │   └── README.md  # 開発環境用のREADME
│   ├── staging  # ステージング環境用のディレクトリ
│   │   ├── main.tf  # ステージング環境のメイン設定ファイル
│   │   ├── backend.tf  # ステージング環境のバックエンド設定ファイル
│   │   └── README.md  # ステージング環境用のREADME
│   └── production  # 本番環境用のディレクトリ
│       ├── main.tf  # 本番環境のメイン設定ファイル
│       ├── backend.tf  # 本番環境のバックエンド設定ファイル
│       └── README.md  # 本番環境用のREADME
└── modules  # モジュールを格納するディレクトリ
    ├── vpc  # VPC関連の設定を格納するディレクトリ
    │   ├── vpc.tf  # VPCのメイン設定ファイル
    │   ├── variables.tf  # VPCの変数設定ファイル
    │   ├── outputs.tf  # VPCの出力設定ファイル
    │   ├── providers.tf  # VPCのプロバイダー設定ファイル
    │   └── README.md  # VPC用のREADME
    ├── subnet  # サブネット関連の設定を格納するディレクトリ
    │   ├── subnet.tf  # サブネットのメイン設定ファイル
    │   ├── variables.tf  # サブネットの変数設定ファイル
    │   ├── outputs.tf  # サブネットの出力設定ファイル
    │   ├── providers.tf  # サブネットのプロバイダー設定ファイル
    │   └── README.md  # サブネット用のREADME
    ├── route-table  # ルートテーブル関連の設定を格納するディレクトリ
    │   ├── route-table.tf  # ルートテーブルのメイン設定ファイル
    │   ├── variables.tf  # ルートテーブルの変数設定ファイル
    │   ├── outputs.tf  # ルートテーブルの出力設定ファイル
    │   ├── providers.tf  # ルートテーブルのプロバイダー設定ファイル
    │   └── README.md  # ルートテーブル用のREADME
    ├── vpc-endpoint  # VPCエンドポイント関連の設定を格納するディレクトリ
    │   ├── vpc-endpoint.tf  # VPCエンドポイントのメイン設定ファイル
    │   ├── variables.tf  # VPCエンドポイントの変数設定ファイル
    │   ├── outputs.tf  # VPCエンドポイントの出力設定ファイル
    │   ├── providers.tf  # VPCエンドポイントのプロバイダー設定ファイル
    │   └── README.md  # VPCエンドポイント用のREADME
    ├── internet-gateway  # インターネットゲートウェイ関連の設定を格納するディレクトリ
    │   ├── internet-gateway.tf  # インターネットゲートウェイのメイン設定ファイル
    │   ├── variables.tf  # インターネットゲートウェイの変数設定ファイル
    │   ├── outputs.tf  # インターネットゲートウェイの出力設定ファイル
    │   ├── providers.tf  # インターネットゲートウェイのプロバイダー設定ファイル
    │   └── README.md  # インターネットゲートウェイ用のREADME
    ├── nat-gateway  # NATゲートウェイ関連の設定を格納するディレクトリ
    │   ├── nat-gateway.tf  # NATゲートウェイのメイン設定ファイル
    │   ├── variables.tf  # NATゲートウェイの変数設定ファイル
    │   ├── outputs.tf  # NATゲートウェイの出力設定ファイル
    │   ├── providers.tf  # NATゲートウェイのプロバイダー設定ファイル
    │   └── README.md  # NATゲートウェイ用のREADME
    ├── network-acl  # ネットワークACL関連の設定を格納するディレクトリ
    │   ├── network-acl.tf  # ネットワークACLのメイン設定ファイル
    │   ├── variables.tf  # ネットワークACLの変数設定ファイル
    │   ├── outputs.tf  # ネットワークACLの出力設定ファイル
    │   ├── providers.tf  # ネットワークACLのプロバイダー設定ファイル
    │   └── README.md  # ネットワークACL用のREADME
    ├── sg  # セキュリティグループ関連の設定を格納するディレクトリ
    │   ├── sg.tf  # セキュリティグループのメイン設定ファイル
    │   ├── variables.tf  # セキュリティグループの変数設定ファイル
    │   ├── outputs.tf  # セキュリティグループの出力設定ファイル
    │   ├── providers.tf  # セキュリティグループのプロバイダー設定ファイル
    │   └── README.md  # セキュリティグループ用のREADME
    ├── ec2  # EC2関連の設定を格納するディレクトリ
    │   ├── ec2.tf  # EC2のメイン設定ファイル
    │   ├── variables.tf  # EC2の変数設定ファイル
    │   ├── outputs.tf  # EC2の出力設定ファイル
    │   ├── providers.tf  # EC2のプロバイダー設定ファイル
    │   └── README.md  # EC2用のREADME
    ├── s3  # S3関連の設定を格納するディレクトリ
    │   ├── s3.tf  # S3のメイン設定ファイル
    │   ├── variables.tf  # S3の変数設定ファイル
    │   ├── outputs.tf  # S3の出力設定ファイル
    │   ├── providers.tf  # S3のプロバイダー設定ファイル
    │   └── README.md  # S3用のREADME
    ├── alb  # ALB関連の設定を格納するディレクトリ
    │   ├── alb.tf  # ALBのメイン設定ファイル
    │   ├── variables.tf  # ALBの変数設定ファイル
    │   ├── outputs.tf  # ALBの出力設定ファイル
    │   ├── providers.tf  # ALBのプロバイダー設定ファイル
    │   └── README.md  # ALB用のREADME
    ├── rds  # RDS関連の設定を格納するディレクトリ
    │   ├── rds.tf  # RDSのメイン設定ファイル
    │   ├── variables.tf  # RDSの変数設定ファイル
    │   ├── outputs.tf  # RDSの出力設定ファイル
    │   ├── providers.tf  # RDSのプロバイダー設定ファイル
    │   └── README.md  # RDS用のREADME
```

## 実行方法※開発環境の場合

env/developmentにディレクトリを移動

1. Terraform初期化  

    ```bash
    terraform init
    
    ```
2. 以下のコマンドで計画を作成し、`env/development` ファイルを適用する。
    ```bash
    terraform plan 
    ```

3. 実際にリソースを作成。
   ```bash
   terraform apply
   ```

### 削除

1. リソースを削除するコマンド。
    ```bash
    terraform destroy
    ```


## 環境について


```
・本プロジェクトでは開発環境、ステージング環境、本番環境をTerraformで作成する(AutoScaling,EC2,RDSが環境毎にリソースが違います。)
・日本国内利用を想定し、東京リージョンを採用する
・本システムにおいては他システムとの内部ネットワークでの通信を想定しない（IPアドレスの重複を想定しない）
・IAMなどに関しては、マネジメントコンソールを使用。※今後、Terraformで実装する可能性あり
```

- リソース別の環境差異
AutoScaling、EC2、RDSの設定が開発環境、ステージング環境、本番環境で異なります。

```
・AutoScaling: グループサイズの希望・最小・最大キャパシティが環境によって異なります。
・EC2: インスタンスタイプが環境によって異なります。開発環境ではt2.micro、ステージングと本番環境ではm5系を使用します。
・RDS: DBインスタンスクラスが環境によって異なります。開発環境ではdb.r5.large、ステージングと本番環境ではdb.r6g.xlargeを使用します。

```

## 命名規則について


```
・リソースの接頭語（システム名称）については「sample」を接頭語とする
・リソース名は英字小文字、数字で構成する
・基本的な命名規則はsample-{usage}-{role}-{sequence}とする。
  ・{role}はリソースが果たす役割（例: db, webserver, api など）。
  ・{usage} はリソースがどのように使用されるかを示す（例: production, staging, development など）。
  ・{sequence}はリソースの連番や順序を示す（例: 1, 2, 3 など）。
  ・命名例：
   開発環境で使用する第1のデータベースサーバー: sample-dev-db-1
```

## ネットワーク設計

**設計方針**



```
ネットワーク疎通性やセキュリティの許可ルールは最小限にし、用途外の通信は遮断する
冗長性を利用できるように2つのAvailability Zoneに展開する
VPC CidrブロックはIPv4で許可されている最大の/16ネットマスクとする
サブネットの構成は以下機能毎に分けた3層構成とする
	public: インターネットへの通信可能(InternetGateway経由)＋VPC内の通信
	protected: インターネットへの通信可能（NATGateway経由）＋VPC内の通信
	datastore: VPC内の通信のみ
ネットワークACLによるトラフィック制限は特に行わない。既定相当のルールのみ利用する。
```

### VPC

#### 説明
VPCはAWS内で仮想ネットワークを作成するためのサービスです。VPCを使用することで、プライベートな隔離空間にAWSリソースをデプロイすることができます。

| VPC名 | CIDR | Tenancy | DNSホスト名 | 備考 |
| --- | --- | --- | --- | --- |
| sample-dev-vpc | 10.0.0.0/16 | default | 有効 | IPv6無効化 |

### Subnet

#### 説明
サブネットは、AWSのVPC内でネットワークをさらに細かく分割するための概念です。サブネットを用いることで、ネットワークのトラフィックやリソースの配置、セキュリティの管理などが柔軟に行えるようになります。

「sample」プロジェクトのサブネット設計では、サブネットを役割ごとに分けることで、セキュリティと可用性の両方を確保しています。

- **Public Subnet**: 一般的なアクセスが許可されるサブネットで、インターネットゲートウェイへのルートが設定されています。主にWebサーバなどの外部からのアクセスが必要なリソースを配置します。
- **Protected Subnet**: 外部からのアクセスは制限され、特定のリソースのみが許可されるサブネットです。アプリケーションサーバなどの中間層のリソースを配置します。
- **Datastore Subnet**: データベースやストレージなどのデータ関連のリソースを配置するサブネットで、非常に厳格なアクセス制御が施されています。

| サブネット名 | CIDR | Availability Zone | RouteTable | ネットワーク ACL | 備考 |
| --- | --- | --- | --- | --- | --- |
| sample-dev-public-subnet1a | 10.0.0.0/24 | ap-northeast-1a | sample-dev-public-rtb | sample-dev-nacl | 外部との通信が多いリソース配置 |
| sample-dev-public-subnet1c | 10.0.1.0/24 | ap-northeast-1c | sample-dev-public-rtb | sample-dev-nacl | 外部との通信が多いリソース配置 |
| sample-dev-protected-subnet1a | 10.0.10.0/24 | ap-northeast-1a | sample-dev-protected-rtb1a | sample-dev-nacl | アプリケーションサーバ配置 |
| sample-dev-protected-subnet1c | 10.0.11.0/24 | ap-northeast-1c | sample-dev-protected-rtb1c | sample-dev-nacl | アプリケーションサーバ配置 |
| sample-dev-datastore-subnet1a | 10.0.20.0/24 | ap-northeast-1a | sample-dev-datastore-rtb | sample-dev-nacl | データベース、ストレージ配置 |
| sample-dev-datastore-subnet1c | 10.0.21.0/24 | ap-northeast-1c | sample-dev-datastore-rtb | sample-dev-nacl | データベース、ストレージ配置 | 


### RouteTable

#### 説明

RouteTableは、VPC内の通信のルーティングを制御するためのAWSリソースです。これにより、サブネット内のインスタンスが通信する先のIPアドレス範囲(Destination)とその通信先(Target)をマッピングします。以下は「sample」プロジェクトのRouteTable設計です。

- **sample-dev-public-rtb**: 
  - このルートテーブルはpublicサブネットに関連付けられ、インターネットゲートウェイを介してインターネットとの通信が可能です。
  - S3への通信は特別なエンドポイントを通じて行います。

- **sample-dev-protected-rtb1a** と **sample-dev-protected-rtb1c**: 
  - これらのルートテーブルはprotectedサブネットに関連付けられます。
  - NATゲートウェイを通じて、インターネット上のリソースとの間での通信が許可されていますが、直接外部からのアクセスは制限されています。
  - 同じく、S3への通信は特別なエンドポイントを通じて行います。

- **sample-dev-datastore-rtb**: 
  - このルートテーブルはdatastoreサブネットに関連付けられています。
  - データストアリソースの通信は、他のリソースとの内部通信が主となるため、インターネットへの直接のルートは設定されていません。
  - S3への通信は特定のエンドポイントを通じて行われます。

| ルートテーブル名 | Destination | Target |
| --- | --- | --- |
| sample-dev-public-rtb | local | - |
|  | s3のマネージドプレフィックスリスト | sample-dev-s3-gw-endpoint |
|  | 0.0.0.0/0 | sample-dev-igw |
| sample-dev-protected-rtb1a | local | - |
|  | s3のマネージドプレフィックスリスト | sample-dev-s3-gw-endpoint |
|  | 0.0.0.0/0 | sample-dev-ngw1a |
| sample-dev-protected-rtb1c | local | - |
|  | s3のマネージドプレフィックスリスト | sample-dev-s3-gw-endpoint |
|  | 0.0.0.0/0 | sample-dev-ngw1c |
| sample-dev-datastore-rtb | local | - |
|  | s3のマネージドプレフィックスリスト | sample-dev-s3-gw-endpoint |

### VPCエンドポイント

#### 説明

VPCエンドポイントは、AWSのVPC内からAWSのサービスにプライベートに接続するためのリソースです。これにより、VPC内のリソースとAWSのサービスとの間で、インターネットを経由せずに直接通信することが可能となります。これはセキュリティとパフォーマンスの向上に寄与します。

特に、S3のGatewayタイプのエンドポイントは、VPC内のリソースからS3バケットに直接、プライベートな通信経路でアクセスするために使用されます。これにより、データの移動がインターネット上のトラフィックに晒されるリスクを軽減しつつ、低遅延でのアクセスを実現します。

以下は「sample」プロジェクトのVPCエンドポイント設計です。

| 名前 | サービス名 | タイプ | 作成するVPC | 利用目的 |
| --- | --- | --- | --- | --- |
| sample-dev-s3-gw-endpoint | com.amazonaws.ap-northeast-1.s3 | Gateway | sample-dev-vpc | S3バケットへの通信 |


### InternetGateway

#### 説明

Internet Gateway (IGW) は、VPCとインターネットの間の双方向の通信を可能にするためのVPCコンポーネントです。これを使用することで、VPC内のリソースは外部のインターネットと直接通信が可能となり、外部のリソースもVPC内のリソースと通信することができます。IGWの存在によって、EC2インスタンスやその他のリソースは、インターネットにアクセスできるようになるだけでなく、公開サブネット内のリソースはインターネットから直接アクセスされることも可能となります。

IGWは特定のVPCにアタッチする必要があり、VPCごとに1つのIGWを持つことができます。これにより、VPC内のリソースは、NATゲートウェイやNATインスタンスを使用することなくインターネットへアクセスすることができます。

以下は「sample」プロジェクトのInternet Gatewayの詳細です。

| 項目 | 内容 | 備考(何かあれば記載) |
| --- | --- | --- |
| タグ Name | sample-dev-igw |  |

**アタッチ**

| InternetGateway名 | 対象VPC |
| --- | --- |
| sample-dev-igw | sample-dev-vpc |

### NAT Gateway

#### 説明

NAT Gatewayは、プライベートサブネット内のリソースがインターネットにアウトバウンド接続を行うためのVPCコンポーネントであり、インターネットからの受信トラフィックは許可しません。NAT Gatewayは高可用性を持ち、AWSが自動的に可用性ゾーン間での冗長性を提供します。

NAT Gatewayを使用することで、プライベートサブネット内のインスタンスやデータベースなどのリソースは、インターネット上のリソース（例えば、ソフトウェアの更新や、外部APIへのアクセス）と通信することができます。しかし、この通信はアウトバウンドのみであり、インターネット上のリソースから直接アクセスされることはありません。

NAT Gatewayは通常、パブリックサブネットに配置され、関連するプライベートサブネットのルートテーブルを更新して、インターネットバウンドトラフィックがNAT Gatewayを経由するように設定します。

| NATGateway名 | サブネット | 接続タイプ | 備考 |
| --- | --- | --- | --- |
| sample-dev-ngw1a | sample-dev-public-subnet1a | パブリック | 構築しないとパブリックIPアドレスは分からないので記載なしでOK |
| sample-dev-ngw1c | sample-dev-public-subnet1c | パブリック | 構築しないとパブリックIPアドレスは分からないので記載なしでOK |


### ネットワークACL

#### 説明

ネットワークアクセス制御リスト（Network ACL、NACL）は、VPC内のサブネットをまたがるリソース間の通信を制御するためのレイヤー4のステートレスファイアウォールとして機能します。各サブネットはNACLに関連付けられており、このリストにはインバウンドとアウトバウンドの両方のトラフィックルールが含まれています。


- ステートレス: NACLはステートレスであり、セッションの状態を追跡しません。したがって、インバウンドとアウトバウンドのトラフィックの両方に対してルールを設定する必要があります。
  
- ルール番号: NACLはルール番号を使用して、トラフィックを許可または拒否するルールの順序を決定します。低い番号のルールが先に評価されます。


| ルール名 | 備考 |
| --- | --- |
| sample-dev-nacl |  |

**インバウンドルール**

| ルール番号 | タイプ | プロトコル | ポート範囲 | 送信元 | 許可/拒否 |
| --- | --- | --- | --- | --- | --- |
| 100 | すべてのトラフィック | すべて | すべて | 0.0.0.0/0 | Allow |
| * | すべてのトラフィック | すべて | すべて | 0.0.0.0/0 | Deny |

**アウトバウンドルール**

| ルール番号 | タイプ | プロトコル | ポート範囲 | 送信元 | 許可/拒否 |
| --- | --- | --- | --- | --- | --- |
| 100 | すべてのトラフィック | すべて | すべて | 0.0.0.0/0 | Allow |
| * | すべてのトラフィック | すべて | すべて | 0.0.0.0/0 | Deny |



## セキュリティグループ設計

### 設計方針

```
VPC環境内では、通信の制御はセキュリティグループの関連付けを通じて実施する。
外部への送信(OutBound)は基本的には制約を設けない（NACLの使用は避ける）。
EC2インスタンスへのアクセスは、SSM(Session Manager)を用いる方式とする。
SSM障害時向けに以下を行う
		- EC2構築時にキーペアの発行
		- 通常時SGへのSSH穴あけは行わない（障害時にのみ、発注者様にてSSHを追加)
		- SSM障害時にのみPublicサブネットに踏み台サーバの構築を実施（発注者様にて実施）
外部へのHTTPS通信は許可されるが、VPC内部の通信はHTTPを用いる方針とする。

```


### ユーザ用ALBセキュリティグループ

| 名前 | 備考 |
| --- | --- |
| sample-dev-alb-users-sg |  |

**インバウンド**

| Type | Protocol | PortRange | Source | 備考(何かあれば記載) |
| --- | --- | --- | --- | --- |
| HTTPS | TCP | 443 | 0.0.0.0/0 | インターネットからの通信 |

**アウトバウンド**

| Type | Protocol | PortRange | Source | 備考(何かあれば記載) |
| --- | --- | --- | --- | --- |
| すべてのトラフィック | すべて | すべて | 0.0.0.0/0 |  |

説明：  
このセキュリティグループは、ALB（Application Load Balancer）を利用してユーザからのHTTPS通信を受け付けるためのものです。インターネットからの全てのHTTPSトラフィックを受け入れる設定となっており、アウトバウンド通信は制限なく全てを許可しています。

### ユーザ用EC2セキュリティグループ

| 名前 | 備考 |
| --- | --- |
| sample-dev-users-sg |  |

**インバウンド**

| Type | Protocol | PortRange | Source | 備考(何かあれば記載) |
| --- | --- | --- | --- | --- |
| HTTP | TCP | 80 | sample-dev-alb-users-sg |  |

**アウトバウンド**

| Type | Protocol | PortRange | Source | 備考(何かあれば記載) |
| --- | --- | --- | --- | --- |
| すべてのトラフィック | すべて | すべて | 0.0.0.0/0 |  |

説明：  
このセキュリティグループは、ユーザ向けのEC2インスタンスに関連付けられ、ALBからのHTTPトラフィックのみを受け入れる設定となっています。アウトバウンド通信は制限なく全てを許可しています。

### RDSセキュリティグループ

| 名前 | 備考 |
| --- | --- |
| sample-dev-rds-sg |  |

**インバウンド**

| Type | Protocol | PortRange | Source | 備考(何かあれば記載) |
| --- | --- | --- | --- | --- |
| MySQL | TCP | 3306 | sample-dev-users-sg |  |

**アウトバウンド**

| Type | Protocol | PortRange | Source | 備考(何かあれば記載) |
| --- | --- | --- | --- | --- |
| すべてのトラフィック | すべて | すべて | 0.0.0.0/0 |  |

説明：  
このセキュリティグループはRDS (Relational Database Service) 用に設計されており、特定のEC2インスタンスからのMySQL通信のみを許可する設定となっています。アウトバウンド通信は制限なく全てを許可しています。




## S3設計

### 基本方針

```
バケット名の一意性を確保するため、末尾にAWSアカウントIDを付与する
全てのバケットにおいて汎用的な標準ストレージクラスを用いる
バックアップを目的とし、バージョニングを有効化する
```


| バケット名 | 用途 | 備考 |
| --- | --- | --- |
| sample-dev-images-s3-"10桁のランダム整数" |  | 画像保存用 |
| sample-dev-alb-log-s3-"10桁のランダム整数" | ALBやその他ログ用 |  |

### バケットごとの詳細設計


**画像保存用バケット**

| 項目 | 値 | 備考 |
| --- | --- | --- |
| リージョン | 東京リージョン |  |
| ACL | 無効 |  |
| パブリックアクセス | すべてブロック |  |
| バージョニング | 有効 | バックアップ目的 |
| 暗号化 | 有効 |  |
| キータイプ | SSE-S3 |  |
| オブジェクトロック | 無効 |  |

割り当てるバケットポリシー

```
ー
```

**ALBやその他ログ用バケット**

| 項目 | 値 | 備考 |
| --- | --- | --- |
| リージョン | 東京リージョン |  |
| ACL | 無効 |  |
| パブリックアクセス | すべてブロック |  |
| バージョニング | 無効 |  |
| 暗号化 | 有効 |  |
| キータイプ | SSE-S3 |  |
| オブジェクトロック | 無効 |  |
| ライフサイクル | 365日保存の後削除 | https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/object-lifecycle-mgmt.html |

割り当てるバケットポリシー

```
ー
```

## IAM設計

### XX用IAMロール

| 項目 | 内容 | 備考(何かあれば記載) |
| --- | --- | --- |
| IAM名 | sample-dev-ec2-iam-role |  |
| ユースケース | EC2 |  |

**アタッチするマネージドポリシー**

| ポリシー名 | 用途 | 備考(何かあれば記載) |
| --- | --- | --- |
| AmazonSSMManagedInstanceCore | EC2へSession managerでログインするため |  |

**カスタムポリシー**

| ポリシー名 | 用途 | 備考(何かあれば記載) |
| --- | --- | --- |
| sample-dev-ec2-iam-access-to-s3-policy | S3に保存された画像の読み取り、保存用 |  |

```json
{
    "Version": "2012-10-17",
    "Statement": [
				{
						"Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
				},
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::sample-dev-images-10桁のランダム整数"
        },
				{
            "Effect": "Allow",
            "Action": [
							"s3:GetObject",
							"s3:DeleteObject",
							"s3:PutObject"
						],
            "Resource": "arn:aws:s3:::sample-dev-images-s3-10桁のランダム整数/*"
				}
    ]
}
```

## ALB設計


### 設計方針

```
HTTPSのセキュリティポリシーにはELBSecurityPolicy-2016-08を用いる
一般公開用ALB（ユーザ向けALB）では80ポート（HTTP）は使用しない
```

### ユーザ用

**ロードバランサ**

| 項目 | 値 | 備考 |
| --- | --- | --- |
| ロードバランサー名 | sample-dev-users-alb |  |
| スキーム | Internet-facing |  |
| IPアドレスタイプ | IPv4 |  |
| VPC | sample-dev-vpc |  |
| Availability Zone | ap-northeast-1a/c |  |
| サブネット | sample-dev-public-subnet1a
sample-dev-public-subnet1c |  |
| セキュリティグループ | sample-dev-alb-users-sg |  |

**リスナー**

| 項目 | 内容 | 備考(何かあれば記載) |
| --- | --- | --- |
| プロトコル | HTTPS |  |
| ポート | 443 |  |
| セキュリティポリシー | ELBSecurityPolicy-2016-08 |  |
| デフォルトの SSL/TLS 証明書 | example.com |  |
| ルール | パスが /*: sample-dev-users-tgへ転送 | 
 |


### ターゲットグループ

**一覧**

| TargetGorup名 | 紐づくALB | ターゲット | 備考 |
| --- | --- | --- | --- |
| sample-dev-users-tg | sample-dev-users-alb |  |  |

**設定値（全ターゲットグループ共通）**

| 項目 | 値 | 備考 |
| --- | --- | --- |
| ターゲットタイプ | インスタンス |  |
| プロトコル | HTTP |  |
| ポート | 80 |  |
| プロトコルバージョン | HTTP1 |  |
| ヘルスチェックプロトコル | HTTP |  |
| ヘルスチェックパス | / |  |
| ヘルスチェックポート | Traffic port |  |
| Healthy threshold | 5回 |  |
| Unhealthy threshold | 2回 |  |
| タイムアウト | 5秒 |  |
| インターバル | 6秒 | デフォルト30秒 |
| Success codes | 200 |  |


## EC2インスタンス設計


```
AmazonLinux2の最新版をAMIとして採用する。
検証用ということで安価なt2.micro使用する.
ワークロードの具体的な予測が難しいため、m5系の中では最小サイズのインスタンスを選択する。
EC2へのアクセスはSSMを介して行うため、初期のキーペアの発行は行わない。
```



### ユーザ用サーバ

**起動テンプレート**

| 項目                           | 開発環境              | ステージング・本番環境 | 備考                             |
|--------------------------------|-----------------------|------------------------|----------------------------------|
| 起動テンプレート名             | sample-dev-users-template  | 同左                    |                                  |
| 利用OS                         | Amazon Linux 2        | Amazon Linux 2          |                                  |
| インスタンスタイプ             | t2.micro               | m5.large                |                                  |
| サブネット                      | 設計に含めない           | 設計に含めない            |                                  |
| セキュリティグループ            | sample-dev-users-sg    | sample-prod-users-sg     |                                  |
| ルートディスクサイズ(OS領域)    | /dev/xvda：20GB        | /dev/xvda：20GB          | 暗号化有効                        |
| 追加ディスク                   | なし                    | なし                      |                                  |
| ボリュームタイプ                | gp3                     | gp3                       |                                  |
| IOPS                           | 3000                    | 3000                      |                                  |
| スループット                    | 125MiB/s                | 125MiB/s                  |                                  |
| IAMロールの割当                 | sample-dev-ec2-iam-role | sample-prod-ec2-iam-role  | インスタンスプロファイルの設定    |
| 削除保護、停止保護              | 無効                    | 無効                      |                                  |
| SSHキーペア                     | ー                      | ー                        |                                  |

**Autoscaling設計**

| 項目                             | 開発環境                 | ステージング・本番環境    | 備考                             |
|----------------------------------|--------------------------|---------------------------|----------------------------------|
| 名前                             | sample-dev-users-asg     | sample-prod-users-asg      |                                  |
| バージョン                       | Latest                   | Latest                     |                                  |
| VPC                              | sample-dev-vpc           | sample-prod-vpc            |                                  |
| アベイラビリティーゾーンとサブネット | sample-dev-protected-subnet1a/c | sample-prod-protected-subnet1a/c  |                                  |
| ロードバランシング               | 既存にアタッチ            | 既存にアタッチ              |                                  |
| EC2ヘルスチェック                | ELBのヘルスチェック       | ELBのヘルスチェック         |                                  |
| グループサイズ - 希望するキャパシティ | 2                        | 4                          |                                  |
| グループサイズ - 最小キャパシティ   | 2                        | 2                          |                                  |
| グループサイズ - 最大キャパシティ   | 4                        | 10                          |                                  |
| スケーリングポリシー               | ターゲット追跡           | ターゲット追跡              |                                  |
| メトリクスタイプ                   | 平均CPU使用率             | 平均CPU使用率                |                                  |
| ターゲット値                       | 50                       | 50                          |                                  |
| ウォームアップする秒数              | 300                      | 300                         |                                  |
| スケールイン保護                    | 無効化                    | 無効化                       |                                  |
| 通知                              | なし                      | なし                         |                                  |
| タグ                              | Name: sample-dev-users-asg| Name: sample-prod-users-asg |                                  |


**ゴールデンイメージについて**

- Auto scaling groupが構築された後、特定のインスタンスにスケールイン保護を適用する。
- 選定したインスタンスにgolden-instance: trueのタグを付与する。
- パッチの適用やアプリケーションのアップデートは、このゴールデンイメージ上で実施する。
    - アップデート後、該当イメージからAMIを生成し、Auto scaling groupの拡張・縮小を通じてインスタンスをリフレッシュする。

ゴールデンイメージ上で、新しい機能の追加やセキュリティの更新などの変更を行います。変更が完了したら、その状態を一つの「写真」として保存します。この「写真」を基に、新しいコンピューターを作ったり、古いものを新しい状態に更新することができます。

[インスタンスのスケールイン保護を使用する - Amazon EC2 Auto Scaling](https://docs.aws.amazon.com/ja_jp/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html)

---



## データベース（RDS）設計


```
エンジンにはRDS Aurora MySQLを採用、バージョンはMySQL8互換とする
エンドポイントはライターとリーダを用意し書き込みと読み込みでそれぞれ使い分ける
```

### **サブネットグループ**

| サブネットグループ名 | VPC | サブネット | Availability Zone | 備考 |
| --- | --- | --- | --- | --- |
| sample-dev-dbsg | sample-dev-vpc | sample-dev-datastore-subnet1a/c | ap-northeast-1a/c |  |

### RDS設計

#### 基本設定

| 項目 | 開発環境 | ステージング・本番環境 | 備考(何かあれば記載) |
| --- | --- | --- | --- |
| エンジン | Amazon Aurora | Amazon Aurora |  |
| エディション | Amazon Aurora MySQL互換 | Amazon Aurora MySQL互換 |  |
| エンジンバージョン | Aurora MySQL 3 (MySQL8.0) | Aurora MySQL 3 (MySQL8.0) | 構築時の最新とする |
| DBインスタンスクラス | db.r5.large | db.r6g.xlarge |  |
| マルチAZ | 有効 | 有効 |  |

#### パラメータグループ

| グループ名 | パラメータグループファミリー | タイプ | 備考 |
| --- | --- | --- | --- |
| sample-dev-pg-auroracluster | aurora-mysql | DB Cluster Parameter Group | クラスタ用。デフォルトのパラメータグループでは設定値を変更できないためカスタムパラメータグループを作成 |
| sample-prod-pg-auroracluster | aurora-mysql | DB Cluster Parameter Group | クラスタ用。デフォルトのパラメータグループでは設定値を変更できないためカスタムパラメータグループを作成 |
| sample-dev-pg-aurorainstance | aurora-mysql | DB Parameter Group | インスタンス用。デフォルトのパラメータグループでは設定値を変更できないためカスタムパラメータグループを作成 |
| sample-prod-pg-aurorainstance | aurora-mysql | DB Parameter Group | インスタンス用。デフォルトのパラメータグループでは設定値を変更できないためカスタム

