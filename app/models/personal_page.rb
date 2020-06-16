# == Schema Information
#
# Table name: personal_pages
#
#  id                :bigint           not null, primary key
#  about             :text
#  name              :string
#  nickname          :string
#  short_description :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_personal_pages_on_nickname  (nickname) UNIQUE
#  index_personal_pages_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PersonalPage < ApplicationRecord
  include Rails.application.routes.url_helpers
  extend FriendlyId
  friendly_id :nickname
  belongs_to :user
  has_and_belongs_to_many :categories
  has_one_attached :preview
  has_one_attached :avatar
  has_one_attached :cover
  has_one_attached :qr_code
  has_many :donates
  has_many :activities, through: :user
  acts_as_ordered_taggable

  after_save :update_qr
  before_save :update_nickname

  validates :nickname, format: {with: /\A[A-z0-9_\-]*\z/, message: "разрешены только латинские буквы, цифры, тире и нижнее подчеркивание"}

  private

  def update_qr
    if(saved_change_to_nickname?)
      svg = open("http://api.qrserver.com/v1/create-qr-code/?data=#{personal_page_url(self)}&size=2000x2000&format=svg")
      self.qr_code.attach(io: svg, filename: "qr_code_#{nickname}.svg")
    end
  end
  def update_nickname
    if(nickname_changed?)
      self.nickname = '@'+self.nickname.parameterize
    end
  end
end
