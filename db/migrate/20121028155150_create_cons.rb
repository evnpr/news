class CreateCons < ActiveRecord::Migration
  def change
    create_table :cons do |t|
      t.integer :news_id
      t.integer :user_id

      t.timestamps
    end
  end
end
