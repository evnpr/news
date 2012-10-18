class AddUrlToNews < ActiveRecord::Migration
  def change
    add_column :news, :url, :text

  end
end
