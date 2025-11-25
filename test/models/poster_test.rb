require "test_helper"

class PosterTest < ActiveSupport::TestCase
  test "valid with title" do
    poster = Poster.new(title: "Sample", description: "desc")
    assert poster.valid?
  end

  test "invalid without title" do
    poster = Poster.new(title: "")
    assert_not poster.valid?
    assert_includes poster.errors[:title], "can't be blank"
  end
end