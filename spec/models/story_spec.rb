require 'rails_helper'

RSpec.describe Story, type: :model do

  let (:user) { FactoryBot.create(:user) }
  let (:stories) { FactoryBot.create_list(:story, 5, user_id: user.id) }

  it { should have_db_column(:title).of_type(:string) }
  it { should have_db_column(:content).of_type(:text) }
  it { should have_db_index(:user_id) }

  describe "Validations" do
    it 'is valid with valid attributes' do
      expect(stories.first).to be_valid
      expect(stories.last).to be_valid
    end
  end

  describe "Associations" do
    it { should belong_to :user }
  end  

  describe "Methods" do

    describe "Search" do
      it "if input matches title" do
        expect(Story.search("Title")).to match_array Story.where("title like ?", "Title")
      end
      it "if input doesn't match title" do
        expect(Story.search("Incorrect")).to match_array []
      end
    end

    describe "Tag list" do
      it "returns all tags" do
        story = FactoryBot.create(:story_with_tags, user_id: user.id)
        expect(story.tag_list).to eq("tag, tag, tag, tag, tag")
      end
    end

  end
end
