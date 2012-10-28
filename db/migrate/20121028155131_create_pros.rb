class CreatePros < ActiveRecord::Migration
  def change
    create_table :pros do |t|
      t.integer :news_id
      t.integer :user_id

      t.timestamps
    end
  end
end
