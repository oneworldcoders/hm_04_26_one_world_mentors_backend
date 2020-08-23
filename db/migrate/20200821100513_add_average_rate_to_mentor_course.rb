class AddAverageRateToMentorCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :mentor_courses, :average_rate, :integer
  end
end
