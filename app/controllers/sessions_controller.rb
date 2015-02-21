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
      redirect_back_or user   
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  

  
end

