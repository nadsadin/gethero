module PayanywayInteractors
  class CcConfirmationNew
    include Interactor

    def call
      context.cc_confirmation = @cc_confirmation = CcConfirmation.new(amount: 6, status: :unpaid, user: context.user)
      generate_id
      @cc_confirmation.transaction_id = @id
      context.fail! unless @cc_confirmation.save
    end

    def generate_id
      @id = "cc_confirmation_"+SecureRandom.base58(10)
      generate_id if CcConfirmation.find_by(transaction_id: @id).present?
    end
  end
end