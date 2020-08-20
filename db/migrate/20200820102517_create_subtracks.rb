class CreateSubtracks < ActiveRecord::Migration[6.0]
  def change
    create_table :subtracks do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
