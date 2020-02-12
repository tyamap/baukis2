require "rails_helper"

describe Staff::Authenticator do
  describe "#authenticate" do
    it "is true when password is correct" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_truthy
    end

    it "is false when password is wrong" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("xy")).to be_falsey
    end

    it "is false when password is nil" do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    it "is true also when account is suspended" do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_truthy
    end

    it "is false when date is before start" do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    end

    it "is false when date is after end" do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    end
  end
end