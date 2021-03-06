require "rails_helper"

describe "admin manage members", "before log-in" do
  include_examples "a protected admin controller", "admin/staff_members"
end

describe "admin manage members" do
  let(:administrator){create(:administrator)}

  before do
    post admin_session_url,
    params: {
      admin_login_form: {
        email: administrator.email,
        password: "pw"
      }
    }
  end

  describe "show member-list" do
    it "is success" do
      get admin_staff_members_url
      expect(response.status).to eq(200)
    end

    it "forcibly log-out when suspended" do
      administrator.update_column(:suspended, true)
      get admin_staff_members_url
      expect(response).to redirect_to(admin_root_url)
    end

    it "session time out" do
      travel_to Admin::Base::TIMEOUT.from_now.advance(seconds: 1)
      get admin_staff_members_url
      expect(response).to redirect_to(admin_login_url)
    end
  end

  describe "new registration" do
    let(:params_hash){attributes_for(:staff_member)}

    it "redirect to members list page" do
      post admin_staff_members_url, params:{staff_member: params_hash}
      expect(response).to redirect_to(admin_staff_members_url)
    end

    it "catches exception ActionController::ParameterMissing" do
      expect {post admin_staff_members_url}.
      to raise_error(ActionController::ParameterMissing)
    end
  end

  describe "edit" do
    let(:staff_member){create(:staff_member)}
    let(:params_hash){attributes_for(:staff_member)}

    it "set suspended flag" do
      params_hash.merge!(suspended: true)
      patch admin_staff_member_url(staff_member),
        params: {staff_member: params_hash}
      staff_member.reload
      expect(staff_member).to be_suspended
    end

    example "can not patch hashed_password" do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: "x")
      expect{
        patch admin_staff_member_url(staff_member),
          params: {staff_member: params_hash}
      }.not_to change{staff_member.hashed_password.to_s}
    end
  end
end