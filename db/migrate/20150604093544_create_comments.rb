class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |comment|
      comment.integer :user_id
      comment.integer :post_id
      comment.text :body
      comment.timestamps
    end
  end
end
