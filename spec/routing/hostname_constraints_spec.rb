require "rails_helper"

describe "Routing" do
  it "get staff top-page" do
    config = Rails.application.config.baukis2
    url = "http://#{config[:staff][:host]}/#{config[:staff][:path]}"
    expect(get: url).to route_to(
      host: config[:staff][:host],
      controller: "staff/top",
      action: "index"
    )
  end

  it "get admin login-form" do
    config = Rails.application.config.baukis2
    url = "http://#{config[:admin][:host]}/#{config[:admin][:path]}/login"
    expect(get: url).to route_to(
      host: config[:admin][:host],
      controller: "admin/sessions",
      action: "new"
    )
  end
  
  it "get customer top-page" do
    config = Rails.application.config.baukis2
    url = "http://#{config[:customer][:host]}/#{config[:customer][:path]}"
    expect(get: url).to route_to(
      host: config[:customer][:host],
      controller: "customer/top",
      action: "index"
    )
  end

  it "is not routable if the host-name is disable" do
    expect(get: "http:foo.example.jp").not_to be_routable
  end

  it "is not routable if the path does not exist" do
    config = Rails.application.config.baukis2
    expect(get: "http://#{config[:staff][:host]}/xyz").not_to be_routable
  end
end