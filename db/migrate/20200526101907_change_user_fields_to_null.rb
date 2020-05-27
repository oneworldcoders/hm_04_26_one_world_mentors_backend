class ChangeUserFieldsToNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :first_name, from: false, to: true
    change_column_null :users, :last_name, from: false, to: true
    change_column_null :users, :password, from: false, to: true
  end
end
