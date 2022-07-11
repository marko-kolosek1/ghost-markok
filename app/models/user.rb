class User < ApplicationRecord

  before_create :make_slug

  after_update :make_slug

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    admin: 0,
    author: 1,
    editor: 2
  }

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :author
  end

  private

  def make_slug
    self.slug = self.first_name.downcase.gsub(/[^a-z1-9]+/, '-') + self.last_name.chr
  end

end
