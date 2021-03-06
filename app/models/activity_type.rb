# == Schema Information
#
# Table name: activity_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ActivityType < ApplicationRecord
  has_many :activities
  extend FriendlyId
  friendly_id :name, use: [:slugged]
end
