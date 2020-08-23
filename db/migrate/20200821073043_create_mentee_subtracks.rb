class CreateMenteeSubtracks < ActiveRecord::Migration[6.0]
  def change
    create_table :mentee_subtracks do |t|
      t.references :mentee, null: false, foreign_key: true
      t.references :subtrack, null: false, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
