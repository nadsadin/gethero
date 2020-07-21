# == Schema Information
#
# Table name: payments
#
#  id             :bigint           not null, primary key
#  amount         :integer
#  status         :integer
#  target_type    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  target_id      :bigint
#  transaction_id :string
#
# Indexes
#
#  index_payments_on_transaction_id  (transaction_id) UNIQUE
#
require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
