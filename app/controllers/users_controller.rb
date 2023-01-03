class UsersController < ApplicationController
	def new
		@user =User.new
	end

	def index
		@user = User.all
	end
	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "Your account details updated successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def show
		@user = User.find(params[:id])
		@articles =@user.articles
	end

	def create
		@user = User.new(user_params)
		if @user.save
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
end