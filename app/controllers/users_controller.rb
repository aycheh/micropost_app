class UsersController < ApplicationController
  before_filter :authanticate, :only =>[:edit, :update]
  
  
  def show
    @user = User.find(params[:id])
    @title = @user.name 
  end

  def new
    @user  = User.new
    @title = "Sign up"
  end
  
  def create
    @user  = User.new(params[:user])
      if @user.save
       sign_in @user
       redirect_to @user # or like this => redirect_to user_path(@user)
       flash[:success] = "wellcome to micropost app"
      else
      @title = "Sign up"
      render 'new'
      end
  end
  
  def edit 
    @user = User.find_by_id(params[:id])
    @title = "Edit user"
  end
  
  def update 
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
      flash[:success] = "profile updated successfuly"
    else
    @title = "Edit user"
    render 'edit'
    end
  end
  
  # private method
  private
  def authanticate
    #flash[:notice] = "please sign in to accesse this page" 
    deny_access unless signed_in?
  end
  
  
end  
  
