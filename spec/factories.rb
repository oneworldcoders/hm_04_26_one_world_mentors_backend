FactoryBot.define do
  factory :user, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Crypto.md5 }
    user_type { Faker::Name.name }
  end

  factory :course, class: Course do
    courseCode { Faker::Code.asin }
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
