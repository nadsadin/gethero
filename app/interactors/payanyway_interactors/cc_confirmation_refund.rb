module PayanywayInteractors
  class CcConfirmationRefund
    include Interactor
    require 'moneta/api'

    before do
      @cc_confirmation = CcConfirmation.find_by(transaction_id: context.transaction_id)
      @mnt_transaction_id = context.mnt_transaction_id
    end

    def call
      context.fail! unless @cc_confirmation.present?
      service = Moneta::Api::Service.new(Rails.application.credentials.payanyway_user, Rails.application.credentials.payanyway_password, { demo_mode: true })
      refund_request = Moneta::Api::Requests::RefundRequest.new.tap do |request|
        request.transaction_id = @mnt_transaction_id
        request.payment_password = Rails.application.credentials.payanyway_payment_password
      end
      response = service.refund(refund_request)
      if response.get_attribute('statusid').value == 'SUCCEED'
        @cc_confirmation.update(mnt_transaction_id: @mnt_transaction_id, status: :refunded)
        @cc_confirmation.user.update(payment_token: "0#{@mnt_transaction_id}")
      else
        context.fail!
      end
    end

  end
end