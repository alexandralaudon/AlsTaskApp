class AddPtToken < ActiveRecord::Migration
  def change
    add_column :users, :pt_token, :string
  end
end
