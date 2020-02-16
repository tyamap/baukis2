require "rails_helper"

describe "management own account" do
  before do
    post staff_session_url,
      params: {
        staff_login_form: {
          email: staff_member.email,
          password: "pw"
        }
      }
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