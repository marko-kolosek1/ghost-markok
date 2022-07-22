require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) { FactoryBot.create(:user) }

  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:role).of_type(:integer) }
  it { should have_db_column(:bio).of_type(:text) }
  it { should have_db_column(:first_name).of_type(:string) }
  it { should have_db_column(:last_name).of_type(:string) }
  it { should have_db_column(:slug).of_type(:string)}
  it { should have_db_column(:avatar).of_type(:string) }

  describe "Associations" do
    it { should have_many(:stories) }
  end

  describe "when email is not present" do
    before { user.email = ' ' }
    it { should_not be_valid }
  end

  describe "Methods" do

    describe "admin" do
      it "is admin" do
        user.role = "admin"
        expect(user.admin?).to eq true
      end
      it "is not admin" do
        user.role = "author"
        expect(user.admin?).to eq false
      end
    end

    describe "invitation_accepted" do
      it "is accepted" do
        user.invitation_accepted_at = Time.now
        expect(user.invitation_accepted?).to eq "accepted"
      end
      it "is not accepted" do
        user.invitation_accepted_at = nil
        expect(user.invitation_accepted?).to eq "pending"
      end
    end

  end
end
