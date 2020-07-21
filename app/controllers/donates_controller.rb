class DonatesController < ApplicationController
  layout 'clientside/transparent_top_bar'
  def new
    @personal_page = PersonalPage.friendly.find(params[:personal_page_id])
    @donate = @personal_page.donates.build
  end
  def create
    @personal_page = PersonalPage.friendly.find(params[:personal_page_id])
    @donate = @personal_page.donates.build(donates_params)
    if @donate.save!
      result = PayanywayInteractors::PaymentNew.call(target: @donate, amount: @donate.amount, description: "Донат для #{@personal_page.name}")
      if result.success?
        redirect_to result.payment_link
      else
        raise ActiveRecord::Rollback, "Не удалось создать платеж!"
      end
    else
      redirect_to @personal_page, notice: "Не удалось создать донат"
    end

  end

  private

  def donates_params
    params.require(:donate).permit(:amount, :comment)
  end
end