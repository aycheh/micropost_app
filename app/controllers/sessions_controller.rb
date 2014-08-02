class SessionsController < ApplicationController
  
  
  def new
    @title = "Sing in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],params[:session][:password])                                                                                                                                                               
    if user.nil? 
    flash.now[:error] = "Invalid user Email/Password combination"
    @title = "Sing in"
    render 'new'
    else
      # Hendling successful sign in.
      sign_in(user)
      redirect_to user
    end
  end
  
  def destroy
  end
  
end

