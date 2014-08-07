module SessionsHelper
  
  
  
  def sign_in(user) 
  cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  current_user = user  
  end
  
#Example how the cookies session work  
  # cookies[:remember_token] = {:value => user.id, 
                             # :expires => 20.years.from_now.utc}
  # User.find_by_id(cookies[:remember_token])                             
  
  def current_user=(user)
     @current_user = user
  end
  
  def  current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(remember_token)
    current_user = nil
    # I added this line, it helps to see the signin link on root_path when clicking on the signout link after user signin
    cookies.permanent.signed[:remember_token] = [nil,nil]
  end
  
  private 
  
  def user_from_remember_token 
    User.authenticate_with_salt(*remember_token)
  end
  
  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
  
  
  
end
