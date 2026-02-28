require "application_system_test_case"

class OrganizationsTest < ApplicationSystemTestCase
  setup do
    @organization = organizations(:one)
    @user = users(:one)
  end

  test "should create organization" do
    visit new_organization_url
    fill_in "Name", with: @organization.name
    fill_in "Email", with: @user.email
    click_button "Create organization"
    visit organization_url(@organization)
    assert_text "[ MyString ]"
    assert_current_path organization_path(@organization)
  end
end
