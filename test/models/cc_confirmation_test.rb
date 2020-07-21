# == Schema Information
#
# Table name: cc_confirmations
#
#  id                 :bigint           not null, primary key
#  amount             :string
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  mnt_transaction_id :string
#  transaction_id     :string
#  user_id            :bigint
#
# Indexes
#
#  index_cc_confirmations_on_transaction_id  (transaction_id) UNIQUE
#  index_cc_confirmations_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class CcConfirmationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
