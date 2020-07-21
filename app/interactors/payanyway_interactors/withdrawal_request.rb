module PayanywayInteractors
  class WithdrawalRequest
    include Interactor
    require 'moneta/api'

    before do
      @user = context.user
    end

    def call
      context.fail!(error: "Не привязана карта для вывода средств.") unless @user.payment_token.present?
      context.fail!(error: "Недостаточно средств для вывода. Минимальная сумма 1000р.") if @user.balance < 1000
      generate_id
      context.withdrawal = @withdrawal = Withdrawal.new.tap do |w|
        w.user = @user
        w.client_transaction = @id
        w.status = 'CREATED'
        w.amount = @user.balance
      end
      context.fail!(error: "Ошибка создания запроса") unless @withdrawal.save
      service = Moneta::Api::Service.new(Rails.application.credentials.payanyway_user, Rails.application.credentials.payanyway_password, { demo_mode: true })
      withdrawal_request = Moneta::Api::Requests::PaymentRequest.new.tap do |request|
        request.payer = Rails.application.credentials.payanyway_payer
        request.payee = 279
        request.is_payer_amount = true
        request.payment_password = Rails.application.credentials.payanyway_payment_password
        request.amount = @user.balance
        request.client_transaction = @id
      end
      payment_token = Moneta::Api::Types::KeyValueAttribute.build(key: 'PAYMENTTOKEN', value: @user.payment_token)
      tariff = Moneta::Api::Types::KeyValueAttribute.build(key: 'SOURCETARIFFMULTIPLIER', value: @withdrawal.amount*0.2)
      withdrawal_info = Moneta::Api::Types::OperationInfo.new
      withdrawal_info.add_attribute(payment_token)
      withdrawal_info.add_attribute(tariff)
      withdrawal_request.operation_info = withdrawal_info
      response = service.payment(withdrawal_request)

      @withdrawal.update(status: response.get_attribute('statusid').value)
      @user.update_balance
    end

    def generate_id
      @id = "withdrawal"+SecureRandom.base58(10)
      generate_id if Withdrawal.find_by(client_transaction: @id).present?
    end
  end
end