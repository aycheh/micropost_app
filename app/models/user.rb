class User < ActiveRecord::Base
  attr_accessible :email, :name
  email_regex = /\A[\w.+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name , :presence => true ,
                    :length => {:maximum => 50 ,:minimum => 2 }
  validates :email, :presence => true ,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitiv => false}
# validates :name , :length => {:maximum => 50}
# validates :name , :length => {:minimum => 4}
                    
end
