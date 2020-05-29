class Admin::WithdrawalsController < ApplicationController
  layout 'container_layout'
  def index
    @withdrawals = policy_scope(Withdrawal).all
  end
  def show
    @withdrawal = @withdrawal.find(params[:id])
    authorize @withdrawal
  end
  def new
    result = PayanywayInteractors::WithdrawalRequest.call(user: current_user)
    if result.success?
      redirect_to admin_withdrawals_path, notice: "Запрос успешно выполнен"
    else
      redirect_to admin_withdrawals_path, flash[:alert] = "Не удалось создать запрос: #{result.error}"
    end
  end
  def create
  end
  def cc_confirmation
    authorize Withdrawal
    result = PayanywayInteractors::CcConfirmationNew.call(user: current_user)
    if result.success?
      redirect_to Payanyway::Gateway.payment_url(
          transaction_id: result.cc_confirmation.transaction_id,
          amount: result.cc_confirmation.amount,
          description: "Оплата для верификации карты на сумму #{result.cc_confirmation.amount}руб.",
          success_url: payanyway_engine.payanyway_on_success_url,
          in_progress_url: payanyway_engine.payanyway_in_progress_url,
          fail_url: payanyway_engine.payanyway_on_fail_url,
          )
    else
      flash[:alert] = "Не удалось отправить запрос, попробуйте еще раз позже или обратитесь к администратору"
      redirect_to admin_withdrawals_path
    end
  end
end