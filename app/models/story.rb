class Story < ApplicationRecord
  belongs_to :user

  scope :author_stories, -> (user) { joins(:user).where("user_id = #{user.id}").order(created_at: :desc) }
end
