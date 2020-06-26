class UsersAddPasswordDigest < ActiveRecord::Migration[6.0]
  def change
		add_column :users, :passowrd_digest, :string
  end
end
