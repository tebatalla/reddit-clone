class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :sub_id, null: false, index: true
      t.integer :author_id, null: false, index: true
      t.string :title, null: false
      t.string :url
      t.text :content

      t.timestamps null: false
    end
  end
end
