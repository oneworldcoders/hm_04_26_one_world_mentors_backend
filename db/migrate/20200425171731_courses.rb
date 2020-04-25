class Courses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :courseCode, null: false
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
