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
require 'test_helper'

class ActivityTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
