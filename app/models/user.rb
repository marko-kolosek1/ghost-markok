class User < ApplicationRecord

  before_create :initialize_default_name

  before_create :set_default_role

  after_create :make_slug

  after_update :make_slug

  mount_uploader :avatar, AvatarUploader

  paginates_per 20

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    admin: 0,
    author: 1,
    editor: 2
  }

  def invitation_accepted?
    if self.invitation_accepted_at != nil
      "accepted"
    else
      "pending"
    end
  end

  private

  def set_default_role
    self.role = "author"
  end

  def initialize_default_name
    self.first_name = "Name"
    self.last_name = "Surname"
  end

  def make_slug
    self.slug = self.first_name.downcase.gsub(/[^a-z1-9]+/, '-') + self.last_name.chr
  end

end
