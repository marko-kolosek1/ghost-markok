class UserDecorator < Draper::Decorator
  delegate_all

  def avatar
    h.image_tag("#{avatar_name}", size: "75x100")
  end

  private

  def avatar_name
    if model.avatar.present?
      model.avatar
    else
      "default.jpg"
    end
  end
end
