class UsersController < ApplicationController
	
	def new
		@user = User.new
	end
	
	def show
		@user = User.find(params[:id])
		@articles = @user.articles
	end
	
	def index
		@users = User.all
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update(filter_params)
			flash[:notice] = "User account details updated successfully";
			redirect_to articles_path
		else
			render 'edit'
		end
	end
	
	def create
		@user = User.new(filter_params)
		
		if @user.save
			flash[:notice] = "Welcome to Alpha Blog #{@user.username}!!!, you have been signed up successfully."
			redirect_to articles_path
		else
			render 'new'
		end
		
	end
	
	private
	
	def filter_params
		params.require(:user).permit(:username, :email, :password)
	end
	
end