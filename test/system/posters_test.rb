require "application_system_test_case"

class PostersTest < ApplicationSystemTestCase
  setup do
    @poster_title = "System Test Poster"
    # Ensure test/fixtures/files/sample.jpg exists for this test
    @image_path = Rails.root.join("test/fixtures/files/sample.jpg")
  end

  test "create a poster with image" do
    visit new_poster_path

    fill_in "Title", with: @poster_title
    fill_in "Description", with: "This is a system test poster."
    attach_file "poster_image", @image_path

    click_on "Create Poster"

    assert_text @poster_title
    assert_selector "img"
  end
end