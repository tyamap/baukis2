class Staff::CustomersController < StaffBase
  def index
    @customers = Customer.order(:family_name_kana, :given_name_kana)
      .page(params[:page])
  end
end
