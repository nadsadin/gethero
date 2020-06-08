class PayanywayInteractors::PaymentNew
  include Interactor
  include Rails.application.routes.url_helpers

  before do
    @payment = context.payment = context.target.build_payment(amount: context.amount, transaction_id: SecureRandom.uuid, status: :unpaid)
  end

  def call
    if @payment.save
      context.payment_link = Payanyway::Gateway.payment_url(
          transaction_id: @payment.transaction_id,
          amount: @payment.amount,
          description: context.description,
          success_url: Payanyway::Engine.routes.url_helpers.payanyway_on_success_url(Rails.application.default_url_options),
          in_progress_url: Payanyway::Engine.routes.url_helpers.payanyway_in_progress_url(Rails.application.default_url_options),
          fail_url: Payanyway::Engine.routes.url_helpers.payanyway_on_fail_url(Rails.application.default_url_options),
          )
    else
      context.fail!
    end
  end
end