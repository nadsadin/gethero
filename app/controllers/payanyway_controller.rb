class PayanywayController < ApplicationController
  include Payanyway::Controller
  def success_implementation(transaction_id)
    # вызывается при отправке шлюзом пользователя на Success URL.
    #
    # ВНИМАНИЕ: является незащищенным действием!
    # Для выполнения действий после успешной оплаты используйте pay_implementation
    if transaction_id[:transaction_id].include? 'cc_confirmation'
      @back_default = admin_withdrawals_path
      @cc_confirmation = CcConfirmation.find_by(transaction_id: transaction_id[:transaction_id])
    else
      @tip = Tip.find(transaction_id[:transaction_id])
      @back_default = polymorphic_path(@tip.target)
    end
    render layout: 'clientside/back_button_primary'
  end
  def pay_implementation(params)
    # вызывается при оповещении магазина об
    # успешной оплате пользователем заказа. (Pay URL)
    #
    # params[ KEY ], где KEY # [ :moneta_id, :transaction_id, :operation_id,
    # :amount, :currency, :subscriber_id, :test_mode, :user, :corraccount,
    # :custom1, :custom2, :custom3 ]
    if params[:transaction_id].include? 'cc_confirmation'
      @cc_confirmation = CcConfirmation.find_by(transaction_id: params[:transaction_id])
      @cc_confirmation.user.update(payment_token: "0#{params[:operation_id]}")
      CcConfirmationRefundWorker.perform_in(2.minutes, params[:transaction_id], params[:operation_id])
    else
      @tip = Tip.find(params[:transaction_id])
      @tip.paid!
      @tip.user.update_balance
    end
  end
  def fail_implementation(transaction_id)
    # вызывается при отправке шлюзом пользователя на Fail URL.
    if transaction_id[:transaction_id].include? 'cc_confirmation'
      @back_default = admin_withdrawals_path
      @cc_confirmation = CcConfirmation.find_by(transaction_id: transaction_id[:transaction_id], mnt_transaction_id: params[:operation_id])
      @cc_confirmation.canceled!
    else
      @tip = Tip.find(transaction_id[:transaction_id])
      @tip.canceled!
      @back_default = polymorphic_path(@tip.target)
    end
    render layout: 'clientside/back_button_error'
  end

  protected

  def url_for(options = {} )
    if options.class.to_s == "LocationUser"
      obj = options
      options = {:action=>"show", :controller=>"location_users", :location_id=> obj.location_id, :id => obj.id}
    end
    super(options)
  end
end