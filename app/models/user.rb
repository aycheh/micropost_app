class User < ActiveRecord::Base
# virtual attributes
  
# attr_accessor   :password ,:password_confirmation
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
                        :length => {:within => 6..40}


  before_save :encrypt_password 
  
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  private 
  
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(self.password)
  end
  
  def encrypt(string)
      secure_hash("#{self.salt}--{string}")
  end
  
  def make_salt 
    secure_hash("#{Time.now.utc}--{self.password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
  
end
