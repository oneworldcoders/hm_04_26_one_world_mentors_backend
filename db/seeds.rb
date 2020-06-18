# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

require "./spec/helpers"
include Helpers

5.times do
  FactoryBot.create(:user) unless User.count.positive?
  FactoryBot.create(:mentee) unless Mentee.count.positive?
  FactoryBot.create(:mentor) unless Mentor.count.positive?
  FactoryBot.create(:course) unless Course.count.positive?
  FactoryBot.create(:mentor_course) unless MentorCourse.count.positive?
end
