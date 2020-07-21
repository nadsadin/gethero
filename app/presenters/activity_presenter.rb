class ActivityPresenter < BasePresenter
  def cover_image_url
    if model.cover.attached?
      h.url_for(model.cover.variant(resize: '1920x500^'))
    else
      h.asset_pack_path('media/images/preview.png')
    end
  end
  def preview_url
    if model.preview.attached?
      h.url_for(model.preview.variant(resize: '165x195^'))
    else
      # h.asset_pack_path('media/images/preview.png')
    end
  end
  def price
    if model.cost>0
      "#{model.cost} ₽"
    else
      "Бесплатно"
    end
  end
  def categories_string
    model.categories.pluck(:plural).join(' • ')
  end
  def avatar_url
    if model.avatar.attached?
      h.url_for(model.avatar)
    else
      h.asset_pack_path('media/images/avatar.png')
    end
  end
  def avatar_background
    ['#b71c1c', '#880e4f', '#4a148c', '#311b92', '#1a237e', '#0d47a1', '#01579b', '#006064', '#004d40', '#1b5e20', '#33691e', '#c43e00', '#bf360c'].sample

  end

  # def rating
  #   h.number_to_human(model.reviews.average(:rate)||0, :precision => 1)
  # end
  # def reviews_count
  #   count = model.reviews.count
  #   h.number_to_human(count, :format => '%n%u', :precision => 0, :units => { :thousand => 'K+', :million => 'M+', :billion => 'B+' })
  # end
  # def tips_count
  #   count = model.tips.count
  #   h.number_to_human(count, :format => '%n%u', :precision => 0, :units => { :thousand => 'K+', :million => 'M+', :billion => 'B+' })
  # end
end