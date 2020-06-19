class CreateMentorCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :mentor_courses do |t|
      t.references :mentor, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
