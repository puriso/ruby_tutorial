require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
    def setup
        @admin     = users(:michael)
        @non_admin = users(:archer)
    end
    test "layout links" do
        get root_path
        assert_template 'static_pages/home'
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", contact_path
        assert_select "a[href=?]", login_path
        get signup_path
        assert_select "title", full_title("Sign up")
    end

    test "admin layout links" do
        log_in_as(@admin)
        get root_path
        assert_template 'static_pages/home'
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", contact_path
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", users_path
        assert_select "a[href=?]", user_path(@admin)
        assert_select "a[href=?]", edit_user_path(@admin)
        assert_select "a[href=?]", logout_path
        get signup_path
        assert_select "title", full_title("Sign up")
    end
end
