class UsersController < ApplicationController

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to subs_url, notice: 'Account successfuly created.'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
