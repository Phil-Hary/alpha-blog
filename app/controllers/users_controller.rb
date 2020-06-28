class UsersController < ApplicationController
	
	before_action :require_user, except: [:show, :index, :new, :create]
	before_action :require_same_user, only: [:update, :edit]
	
	def new
		@user = User.new
	end
	
	def show
		@user = User.find(params[:id])
		@articles = @user.articles.paginate(page: params[:page], per_page: 4)
	end
	
	def index
		@users = User.paginate(page: params[:page], per_page: 4)
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update(filter_params)
			flash[:notice] = "User account details updated successfully";
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	def create
		@user = User.new(filter_params)

		if @user.save
			flash[:notice] = "Welcome to Alpha Blog #{@user.username}!!!, you have been signed up successfully."
			session[:user_id] = @user.id
			redirect_to articles_path
		else
			render 'new'
		end
		
	end
	
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		session[:user_id] = nil if @current_user == @user
		flash[:notice] = "Account and all associated articles have been deleted successfully";
		redirect_to root_path
	end
	
	private
	
	def filter_params
		params.require(:user).permit(:username, :email, :password)
	end
	
	def require_same_user
		if current_user != @user
			flash[:alert] = "You can edit only your profile";
			redirect_to current_user
		end
	end
	
end