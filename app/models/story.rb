class Story < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  paginates_per 10

  validates :title, presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  scope :author_stories, -> (user) { joins(:user).where("user_id = #{user.id}").order(created_at: :desc) }

  def self.search(input)
    if input
      Story.where("title like ?", "%#{input}%")
    else
      Story.all
    end
  end

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

end
