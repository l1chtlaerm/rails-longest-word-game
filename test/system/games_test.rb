# test/system/games_test.rb
require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "enter random word..." do
    visit new_url
    assert test: "New game"
    fill_in "answer", value: "dkfjdskfj"
  end
end
