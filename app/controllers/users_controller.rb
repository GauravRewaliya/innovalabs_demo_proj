class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def login_view
    @user = User.new
  end

  def register_view
    @user = User.new
  end
  
  def register
    @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          session[:user_id] = @user.id
          # format.html { redirect_to posts_path, notice: "Logedin successfully " }
          format.json { render json: {user: @user ,session: session} ,status: 200}
        else
          # format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end
  def login
    @user = User.find_by(email: params[:user][:email] , password: params[:user][:password])
      respond_to do |format|
        if !@user.blank?
          session[:user_id] = @user.id
          format.json { render json: session,status: 200}
          # format.html { redirect_to posts_path, notice: "Logedin successfully " }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
          # format.html { render :new, status: :unprocessable_entity }
        end
      end
  end

  def logout 
    session[:user_id] = nil 
    render json: {notice: "logout"},status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email , :password)
  end
end
