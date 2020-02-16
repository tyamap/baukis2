require "rails_helper"

RSpec.describe StaffMember do
  describe "#password=" do
    it "hashes a word when given String" do
      member = StaffMember.new
      member.password = "baukis"
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    it "become nil when given Nil" do
      member = StaffMember.new(hashed_password: "x")
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end

  describe "Normalization" do
    it "strip spaces email" do
      member = create(:staff_member, email: " test@example.com")
      expect(member.email).to eq("test@example.com")
    end

    it "full-width to half-width in email" do
      member = create(:staff_member, email: "ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ")
      expect(member.email).to eq("test@example.com")
    end

    it "strip full-spaces in email" do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq("test@example.com")
    end

    it "hiragana to katakana in family-name-kana" do
      member = create(:staff_member, family_name_kana: "てすと")
      expect(member.family_name_kana).to eq("テスト")
    end

    it "half-katakana to full-katakana in family-name-kana" do
      member = create(:staff_member, family_name_kana: "ﾃｽﾄ")
      expect(member.family_name_kana).to eq("テスト")
    end
  end

  describe "validation" do
    it "disable email include two @" do
      member = build(:staff_member, email: "test@@example.com")
      expect(member).not_to be_valid
    end

    it "enable name include alphabet" do
      member = build(:staff_member, family_name: "Smith")
      expect(member).to be_valid
    end

    it "disable name include symbol" do
      member = build(:staff_member, family_name: "試験★")
      expect(member).not_to be_valid
    end

    it "disable name-kana include kanji" do
      member = build(:staff_member, family_name_kana: "試験")
      expect(member).not_to be_valid
    end

    it "enable name-kana include dash " do
      member = build(:staff_member, family_name_kana: "エリー")
      expect(member).to be_valid
    end

    it "disable email dupulicate" do
      member1 = create(:staff_member)
      member2 = build(:staff_member, email: member1.email)
      expect(member2).not_to be_valid
    end
  end
end
