class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :feed_text

      t.timestamps
    end
  end
end
