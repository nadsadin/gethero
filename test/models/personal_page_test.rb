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
require 'test_helper'

class PersonalPageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
