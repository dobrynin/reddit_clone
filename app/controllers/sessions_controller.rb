class SessionsController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:session][:username],
      params[:session][:password]
    )
    if @user
      login(@user)
      redirect_to subs_url, notice: 'You are now signed in.'
    else
      flash[:errors] = 'Invalid credentials'
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.reset_session_token
    session[:session_token] = nil
    redirect_to subs_url, notice: 'You are now signed out.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password_digest, :session_token)
    end
end
