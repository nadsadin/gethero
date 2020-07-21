class CcConfirmationRefundWorker
  include Sidekiq::Worker

  def perform(transaction_id, mnt_transaction_id)
    result = PayanywayInteractors::CcConfirmationRefund.call(transaction_id: transaction_id, mnt_transaction_id: mnt_transaction_id)
  end
end