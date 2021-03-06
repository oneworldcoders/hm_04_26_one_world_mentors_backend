FactoryBot.define do
    factory :user, class: User do
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
        email { Faker::Internet.email }
        password {Helpers::TEST_PASSWORD}
        user_type { Faker::Name.name }
    end

  factory :course, class: Course do
    courseCode { Faker::Code.asin }
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end

  factory :mentor do
    user
    availabe { Faker::Boolean.boolean }
  end

  factory :mentee do
    user
  end

  factory :mentor_course do
    course
    mentor
  end
end
