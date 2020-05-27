class AddSubToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sub, :string
  end
end
