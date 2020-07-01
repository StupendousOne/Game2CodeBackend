class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :desc
      t.string :answer
      t.string :test_info
      t.integer :line_par
      t.integer :speed_par

      t.timestamps
    end
  end
end
