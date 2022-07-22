FactoryBot.define do
  factory :story do
    association :user

    title { "Title" }
    content { "Story content" }
    user_id { nil }

    factory :story_with_tags do
      after(:create) do |story|
        story.tags << FactoryBot.create_list(:tag, 5)
      end
    end

  end
end
