class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	def new
		@user =User.new
	end

	def index
		@user = User.all
	end
	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "Your account details updated successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def show
		@articles =@user.articles.paginate(page: params[:page], per_page: 5)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] =  "Welcome to UC APP #{@user.username}, Signed Up Successfully"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

end