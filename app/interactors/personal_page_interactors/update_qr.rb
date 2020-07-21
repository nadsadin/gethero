class PersonalPageInteractors::UpdateQr
  include Interactor
  include Rails.application.routes.url_helpers

  before do
    @personal_page = context.personal_page
  end

  def call
    svg = open("http://api.qrserver.com/v1/create-qr-code/?data=#{short_id_url(short_id: @short_id.short_id)}&size=2000x2000&format=svg")
  end
end