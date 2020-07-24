class UpdateMentorsAvailability < ActiveRecord::Migration[6.0]
  def change
    change_column :mentors, :available, :boolean, default: true
  end
end
