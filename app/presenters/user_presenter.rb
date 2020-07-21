class UserPresenter < BasePresenter
  def avatar_url
    if model.avatar.attached?
      h.url_for(model.avatar)
    else
      h.asset_pack_path('media/images/avatar.png')
    end
  end
  def short_name
    "#{model.surname} #{model.name[0]+'.' if model.name.present?} #{model.midname[0]+'.' if model.midname.present?}"
  end
  def full_name
    "#{model.name} #{model.surname}"
  end
  def card_name
    "#{model.name} #{model.surname.first}."
  end
end