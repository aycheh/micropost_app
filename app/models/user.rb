class User < ActiveRecord::Base
  # #virtual attributes #
  
#  attr_accessor   :password ,:password_confirmation
  attr_accessor   :password 
  attr_accessible :email, :name , :password , :password_confirmation
  email_regex = /\A[\w.+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name , :presence => true ,
                    :length => {:maximum => 50 ,:minimum => 2 }
  validates :email, :presence => true ,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitiv => false}
  validates :password , :presence => true, 
                        :confirmation => true ,
                        :length => {:minimum  => 10 ,:maximum => 50 },
                        :length => {:within => 6..40}


                    
end
