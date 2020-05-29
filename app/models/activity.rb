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
#  payment_type      :integer
#  short_description :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  activity_type_id  :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_activities_on_activity_type_id  (activity_type_id)
#  index_activities_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_type_id => activity_types.id)
#  fk_rails_...  (user_id => users.id)
#
class Activity < ApplicationRecord
  belongs_to :activity_type
end
