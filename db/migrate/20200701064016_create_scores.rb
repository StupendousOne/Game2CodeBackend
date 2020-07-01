class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.integer :line_score
      t.integer :speed_score
      t.boolean :completed

      t.timestamps
    end
  end
end
