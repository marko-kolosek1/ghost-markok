FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    role { "admin" }
    email { "admin@admin.com"}
    password { "password" }
    bio { "random bio"}
    slug { first_name + last_name.chr }
    avatar { nil }
  end
end
