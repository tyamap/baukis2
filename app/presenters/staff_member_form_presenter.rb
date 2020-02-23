class StaffMemberFormPresenter < UserFormPresenter
  def suspended_check_box
    markup(:dev, class: "check-boxes") do |m|
      m << check_box(:suspended)
      m << label(:suspended, "アカウント停止")
    end
  end
end
