# == Schema Information
#
# Table name: donates
#
#  id               :bigint           not null, primary key
#  amount           :integer
#  comment          :string
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  personal_page_id :bigint
#
# Indexes
#
#  index_donates_on_personal_page_id  (personal_page_id)
#
# Foreign Keys
#
#  fk_rails_...  (personal_page_id => personal_pages.id)
#
require 'test_helper'

class DonateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
