# README

## アプリケーション名
Study Recall

## アプリケーション概要
学習継続サポートアプリです。主な機能は２つあります。<br>
１つ目は学習を記録として投稿する機能です。タイトル、テキスト、画像が投稿できます。<br>
２つ目は復習サポート機能です。学習から適切な復習の日付を算出し、復習日になると投稿一覧のトップに表示されます。

## URL
https://study-recall.onrender.com

### テスト用アカウント
- **Basic認証**
  - ID：admin
  - PASS：2222
- **ログイン情報**
  - 名前：Study
  - メールアドレス：test@gmail.com
  - パスワード：study_recall

## 利用方法
1. ユーザー新規登録します。
2. 新規投稿から学習内容を投稿します。
3. 本日が復習日となっている投稿を復習し、復習完了ボタンを押します。
4. 「２」「３」を繰り返すことで効果的に学習を進めていきます。

## アプリケーションを作成した背景	
学習を継続できない課題を解決するために作成しました。<br>
学習を継続するには、学習内容を覚えているという成長実感が大切だと思いました。<br>
そこで、効果的な復習のタイミングで過去の学習を表示することを主機能としたアプリを制作しました。

## 実装した機能についての画像やGIFおよびその説明
[![Image from Gyazo](https://i.gyazo.com/dcafe372d78efa2e18c95e785f152f37.gif)](https://gyazo.com/dcafe372d78efa2e18c95e785f152f37)
学習を投稿したときに、復習日が翌日に設定されます。<br>
投稿をクリックすると学習詳細を閲覧できます。このとき、「復習完了」をクリックすると2日後に復習日が設定されます。<br>
設定される復習日に従って学習を進めると、学習日から1日後、3日後、7日後、30日後に復習を行うことになります。

## 洗い出した要件
[要件定義シート](https://docs.google.com/spreadsheets/d/15-NDAK7sf932NnAzekZ0OoOEArOFg8SSahrEeSKpcy4/edit?gid=815875737#gid=815875737)

## 実装予定の機能
- フィルター機能や検索機能の実装
- アウトプットのテンプレート表示
- 復習を虫食いで表示

## データベース設計

### Users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| name               | string | null: false               |

#### アソシエーション

- has_many :studies

---

### Study テーブル

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| title       | string     | null: false                    |
| content     | text       | null: false                    |
| user_id     | references | null: false, foreign_key: true |

#### アソシエーション

- belongs_to :user
- has_many :recalls, dependent: :destroy

---

### Recalls テーブル

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| study_id         | references | null: false, foreign_key: true |
| recall_date      | date       | null: false                    |
| completed        | boolean    | null: false, default: false    |
| interval         | integer    | null: false                    |

#### アソシエーション

- belongs_to :study

### ER図
[![Image from Gyazo](https://i.gyazo.com/41ac0b1bcd50e6316accd67132d2076b.png)](https://gyazo.com/41ac0b1bcd50e6316accd67132d2076b)

## 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/e1eb1fdfa178c02ab3a04b01d93da422.png)](https://gyazo.com/e1eb1fdfa178c02ab3a04b01d93da422)

## 開発環境
Ruby on Rails<br>
Render

## ローカルでの動作方法	
以下のコマンドを順次実行<br>
% git clone https://github.com/kameta1008/study_recall<br>
% cd study_recall<br>
% bundle install<br>
% rails db:create<br>
% rails db:migrate

## 工夫したポイント	
1. 復習予定日の投稿を優先表示
- 本日どの学習を復習すれば良いか学習者にわかりやすくするため
- トップに表示することで復習を実行しやすくするため
2. 復習完了日から次回復習日を起算
- 学習できなかった日があっても、後の復習日がずれ込まない
- 後の復習日がずれ込まないことで、継続的に取り組むモチベーションを維持できるようにする

## 改善点	
- 投稿の優先順位が日付が変わらないと更新されない点
- 投稿一覧の表示順を、動的に更新されるように改善予定。
## 制作時間	
１週間