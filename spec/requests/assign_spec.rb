require "rails_helper"

RSpec.describe Assign do

  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user) }
  let(:course) { course = FactoryBot.create(:course) }

  it 'should create a mentor to mentee relation' do
    mentor = Mentor.create(user:user1, available:true)
    mentee = Mentee.create(id:1, user:user)
    mentor_course = MentorCourse.create(mentor:mentor, course:course)
    Assign.mentor(mentee, course.id)

    expect(mentee.mentor_id).to eq(mentor.id)
  end

  it "should create a course to a mentee relation" do
    mentee = Mentee.create(id:1, user:user)
    updated_mentee = Assign.course(mentee.id, course.id)
    expect(updated_mentee.course_id).to eq(course.id)
  end
end
