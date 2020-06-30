class ArticlesController < ApplicationController

	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :require_user, except: [:show, :index]
	before_action :require_same_user, only: [:update, :destroy, :edit]
	
	def show
	end
	
	def index
		@articles = Article.paginate(page: params[:page], per_page: 4)
	end
	
	def new
		@article = Article.new
	end
	
	def edit
	end
	
	def create
		byebug
		@article = Article.new(filter_params)
		@article.user = current_user
		if @article.save
			flash[:notice] = "Article created successfully."
			redirect_to @article
		else
			render "new"
		end
	end
	
	def update
		if @article.update(filter_params)
			flash[:notice] = "Article updated successfully."
			redirect_to @article
		else
			render "edit"
		end
	end
	
	def destroy
		@article.destroy
		redirect_to articles_path
	end
	
	private
	
	def set_article
		@article = Article.find(params[:id])
	end
	
	def filter_params
		params.require(:article).permit(:title, :description, category_ids: [])
	end
	
	def require_same_user
		if current_user != @article.user
			flash[:alert] = "You can edit or delete only your articles"
			redirect_to @article
		end
	end
	
end