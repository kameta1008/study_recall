class CreateRecalls < ActiveRecord::Migration[7.0]
  def change
    create_table :recalls do |t|
      t.date :recall_date, null: false 
      t.references :study, null: false, foreign_key: true
      t.boolean :completed, default: false, null: false    
      t.integer :interval, null: false                    
      t.timestamps
    end
  end
end
