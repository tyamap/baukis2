require "rails_helper"

describe "staff manage own account", "before log-in" do
  include_examples "a protected singular staff controller", "staff/accounts"
end

describe "staff manage own account" do
  before do
    post staff_session_url,
      params: {
        staff_login_form: {
          email: staff_member.email,
          password: "pw"
        }
      }
  end

  describe "show account-info" do
    let(:staff_member) { create(:staff_member) }

    it "is success" do
      get staff_account_url
      expect(response.status).to eq(200)
    end

    it "forcibly log-out when suspended" do
      staff_member.update_column(:suspended, true)
      get staff_account_url
      expect(response).to redirect_to(staff_root_url)
    end

    it "session time out" do
      travel_to Staff::Base::TIMEOUT.from_now.advance(seconds: 1)
      get staff_account_url
      expect(response).to redirect_to(staff_login_url)
    end
  end

  describe "update" do
    let(:params_hash){attributes_for(:staff_member)}
    let(:staff_member){create(:staff_member)}

    it "can update email" do
      params_hash.merge!(email: "test@example.com")
      patch staff_account_url,
        params: {id: staff_member.id, staff_member: params_hash}
      staff_member.reload
      expect(staff_member.email).to eq("test@example.com")
    end

    it "catch exception ActionController::ParameterMissing" do
      expect {patch staff_account_url, params: {id: staff_member.id}}.
        to raise_error(ActionController::ParameterMissing)
    end

    it "can not update end_date" do
      params_hash.merge!(end_date: Date.tomorrow)
      expect {
        patch staff_account_url,
          params: { id: staff_member.id, staff_member: params_hash }
      }.not_to change { staff_member.end_date }
    end
  end
end