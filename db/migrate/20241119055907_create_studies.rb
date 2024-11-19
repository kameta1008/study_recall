class CreateStudies < ActiveRecord::Migration[7.0]
  def change
    create_table :studies do |t|
      t.string :title,    null: false
      t.text :content,    null:false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
