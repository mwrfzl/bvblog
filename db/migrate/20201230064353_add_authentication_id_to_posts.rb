class AddAuthenticationIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :authentication_id, :integer
    add_index :posts, :authentication_id
  end
end
