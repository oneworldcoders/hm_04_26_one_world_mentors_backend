# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {
    first_name: "Emmanuel",
    last_name: "Omona",
    email: "emma@11",
    password: "P@ss1234",
    user_type: "mentor"
  },
  {
    first_name: "Kenneth",
    last_name: "Ddumba",
    email: "kenneth@11",
    password: "P@ss1234",
    user_type: "mentee"
  }
]

courses = [
  {
    courseCode: "CS001",
    name: "Computer Science",
    description: "Fundamentals of bits"
  }
]

mentors = [
  {
    available: TRUE,
    user_id: 1
  }
]

mentees = [
  {
    user_id: 2,
    course_id: 1
  }
]

mentor_courses = [
  mentor_id: 1,
  course_id: 1
]

users.each do |user|
  user_ = User.new(user)
  User.create(user) if user_.valid?
end

courses.each do |course|
  course_ = Course.new(course)
  Course.create!(course) if course_.valid?
end

mentors.each do |mentor|
  mentor_ = Mentor.new(mentor)
  Mentor.create!(mentor) if mentor_.valid?
end

mentees.each do |mentee|
  mentee_ = Mentee.new(mentee)
  Mentee.create!(mentee) if mentee_.valid?
end

mentor_courses.each do |mentor_course|
  mentor_course = MentorCourse.new(mentor_course)
  MentorCourse.create!(mentor_course)  if mentor_course.valid?
end
