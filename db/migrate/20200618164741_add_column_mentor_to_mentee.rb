class AddColumnMentorToMentee < ActiveRecord::Migration[6.0]
  def change
    add_reference :mentees, :mentor, null: true, foreign_key: true
  end
end
