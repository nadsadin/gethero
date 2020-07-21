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
class Payment < ApplicationRecord
  belongs_to :target, polymorphic: true
  validates :amount, presence: true, numericality: { only_integer: true }

  enum status: [:unpaid, :paid, :in_progress, :canceled]

  def paid!
    self.status = :paid
    self.save!
    self.target.paid!
  end
end
