class CategoriesController < ApplicationController

	before_action :require_admin_user, only: [ :new, :create, :edit, :update ]
	
	def new
		@category = Category.new
	end
	
	def edit
		@category = Category.find(params[:id])
	end
	
	def destroy
		@category = Category.find(params[:id])
		if @category.destroy
			flash[:notice] = "Category deleted successfully"
		end
		redirect_to categories_path
	end
	
	def update
		@category = Category.find(params[:id])
		@category.update(category_params)
		redirect_to @category
	end
	
	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "New category created successfully"
			redirect_to @category
		else
			render "new"
		end
	end
	
	def show
		@category = Category.find(params[:id])
		@articles = @category.articles
	end
	
	def index
		@categories = Category.paginate(page: params[:page], per_page: 4)
	end
	
	private
	
	def category_params
		params.require(:category).permit(:name)
	end
	
	def require_admin_user
		if !(logged_in? and @current_user.admin?)
			flash[:alert] = "You need admin access to perform this actions"
			redirect_to categories_path
		end
	end
	
end