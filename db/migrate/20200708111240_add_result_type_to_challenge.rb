class AddResultTypeToChallenge < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :result_type, :string
  end
end
