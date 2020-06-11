# == Schema Information
#
# Table name: activities
#
#  id                :bigint           not null, primary key
#  age_limit         :integer
#  cost              :integer
#  date_end          :datetime
#  date_start        :datetime
#  description       :text
#  name              :string
#  payment_type      :integer
#  short_description :string
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  activity_type_id  :bigint
#  personal_page_id  :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_activities_on_activity_type_id  (activity_type_id)
#  index_activities_on_personal_page_id  (personal_page_id)
#  index_activities_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_type_id => activity_types.id)
#  fk_rails_...  (personal_page_id => personal_pages.id)
#  fk_rails_...  (user_id => users.id)
#
class Activity < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged]
  has_one_attached :preview
  has_one_attached :cover
  has_and_belongs_to_many :categories
  belongs_to :activity_type
  belongs_to :user
  has_one :personal_page, through: :user
  # belongs_to :personal_page
  acts_as_ordered_taggable
end
