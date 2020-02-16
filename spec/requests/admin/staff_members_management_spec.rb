require "rails_helper"

describe "members management by administrator" do
  let(:administrator){create(:administrator)}

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