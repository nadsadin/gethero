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
class Donate < ApplicationRecord
  belongs_to :personal_page
  has_one :payment, as: :target
  delegate :user, to: :personal_page, allow_nil: true

  validates :amount, presence: true, numericality: { only_integer: true }

  enum status: [:unpaid, :paid, :in_progress, :canceled]

end
