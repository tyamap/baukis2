require "rails_helper"

RSpec.describe Administrator do
  describe "#password=" do
    it "hashes a word when given String" do
      admin = Administrator.new
      admin.password = "baukis"
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end

    it "become nil when given Nil" do
      admin = Administrator.new(hashed_password: "x")
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end
  end
end