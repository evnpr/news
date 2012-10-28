class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.boolean :type
      t.integer :news_id
      t.integer :user_id
      t.float :weight

      t.timestamps
    end
  end
end
