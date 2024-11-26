# README
## データベース設計

### Users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|--------------------- -----|
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

#### アソシエーション

- belongs_to :study