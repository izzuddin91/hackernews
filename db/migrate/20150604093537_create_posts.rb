class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |post|
      post.string :title
      post.text :body
      post.integer :user_id
      post.timestamp
    end
  end
end
