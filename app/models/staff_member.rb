class StaffMember < ApplicationRecord
  # パスワードを文字列で受け取りハッシュ化する
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end
