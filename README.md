# README
## データベース設計

### Users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|--------------------- -----|
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| name               | string | null: false               |

#### アソシエーション

- has_many :study_records

---

### StudyRecords テーブル

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| title       | string     | null: false                    |
| content     | text       | null: false                    |
| user_id     | references | null: false, foreign_key: true |

#### アソシエーション

- belongs_to :user
- has_many :review_schedules, dependent: :destroy

---

### ReviewSchedules テーブル

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| study_record_id  | references | null: false, foreign_key: true |
| review_date      | date       | null: false                    |
| status           | string     | default: "incomplete"          | 

#### アソシエーション

- belongs_to :study_record