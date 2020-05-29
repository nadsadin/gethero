# == Schema Information
#
# Table name: withdrawals
#
#  id                 :bigint           not null, primary key
#  amount             :float
#  client_transaction :string
#  status             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#
# Indexes
#
#  index_withdrawals_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class WithdrawalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
