class UsersController < ApplicationController
  
  def new
    @title = "Sign up"
  end
    def show
    @user = User.find(id = 5)
  end
end
