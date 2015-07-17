class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.integer :parent_comment_id
      t.integer :author_id, null: false
      t.text :content
      t.timestamps null: false
    end
    add_index :comments, :post_id
    add_index :comments, :author_id
  end
end
