require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
	
	def setup
		@category1 = Category.create(name: "Sports")
		@category2 = Category.create(name: "Health")
	end
	
	test "check list of categories" do
		get "/categories"
		assert_match @category1.name, response.body
		assert_match @category2.name, response.body
	end
end
