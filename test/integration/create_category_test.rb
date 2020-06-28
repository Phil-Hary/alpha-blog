require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
	
	def setup
		@admin = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
		sign_in_as(@admin)
	end
	
	test "display create form and create new category - valid" do
		get "/categories/new"
		assert_response :success
		assert_difference 'Category.count', 1 do
			post categories_path, params: { category: { name: "Travel"} }
			assert_response :redirect
		end
		follow_redirect!
		assert_response :success
		assert_match 'Travel', response.body
	end
	
	test "display create form and create new category - invalid" do
		get "/categories/new"
		assert_response :success
		assert_no_difference 'Category.count' do
			post categories_path, params: { category: { name: " "} }
		end
		assert_match 'Error', response.body
		assert_select "div.alert"
	end
	
end
