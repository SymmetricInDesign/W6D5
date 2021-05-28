class SessionsController < ApplicationController
  def new
    render :new
  end  


  def create 
    @user = User.find_by_credentials(
      user_params(params)[:username],
      user_params(params)[:password]
    )

    if @user
      login!(@user)
      redirect_to cats_url
    else
      
      render :new
    end

  end


  def destroy  
    self.current_user
    @current_user.reset_session_token! if !!@current_user
    session[:session_token] = nil 
    @current_user = nil
    redirect_to cats_url
  end

  def user_params(params)
    params.require(:user).permit(:username, :password)
  end

end