class CreateMentees < ActiveRecord::Migration[6.0]
  def change
    create_table :mentees do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, foreign_key: true, index: true, null:true

      t.timestamps
    end
  end
end
