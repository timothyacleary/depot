require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    # test that there are at least 4 links in the sidebar
    assert_select '#columns #side a', minimum: 4
    # test that main section has 3 entries (based on fixture data)
    assert_select '#main .entry', 3
    # test that there is an h3 with title of one of the books
    assert_select 'h3', 'Programming Ruby 1.9'
    # test that prices have the currency format
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "markup needed for store.js.coffee is in place" do
    get :index
    assert_select '.store .entry > img', 3
    assert_select '.entry input[type=submit]', 3
  end


end
