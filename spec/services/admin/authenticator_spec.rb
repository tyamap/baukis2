require "rails_helper"

describe Admin::Authenticator do
  describe "#authenticate" do
    it "is true when password is correct" do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate("pw")).to be_truthy
    end

    it "is false when password is wrong" do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate("xy")).to be_falsey
    end

    it "is false when password is nil" do
      m = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    it "is true also when account is suspended" do
      m = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate("pw")).to be_truthy
    end
  end
end