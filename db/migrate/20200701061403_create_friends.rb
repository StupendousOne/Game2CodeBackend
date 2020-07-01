class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.integer :requestor_id, null: false, foreign_key: true
      t.integer :target_id, null: false, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
