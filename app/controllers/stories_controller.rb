class StoriesController < ApplicationController
  before_action :set_story, except: [:index, :new, :create]
  before_action :set_last_edited, only: [:update], if: :user_signed_in?
  
  def index
    if current_user.role == "admin" || current_user.role == "editor"
      @stories = Story.all.search(params[:search])
    elsif current_user.role == "author"
      @stories = Story.author_stories(current_user).search(params[:search]) 
    end
  end

  def show
    @story
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.user_id = current_user.id
    @story.save

    respond_to do |format|
      format.html { redirect_to user_stories_path, notice: "Story was successfully destroyed." }
    end   
   end

  def update
    @story.update(story_params)

    respond_to do |format|
      format.html { redirect_to user_stories_path, notice: "Story was successfully destroyed." }
    end
  end

  def destroy
    @story.destroy

    respond_to do |format|
      format.html { redirect_to user_stories_path, notice: "Story was successfully destroyed." }
    end
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def set_last_edited
    @story.update_attribute(:last_edited, Time.current)
  end

  def story_params
    params.require(:story).permit(:title, :content)
  end
end
