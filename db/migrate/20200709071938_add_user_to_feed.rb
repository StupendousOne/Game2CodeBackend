class AddUserToFeed < ActiveRecord::Migration[6.0]
  def change
    add_reference :feeds, :user, null: false, foreign_key: true
  end
end
