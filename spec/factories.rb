

  
 # FactoryGirl.define :user do |user|
  # user.name                  "Michael Hartl"
  # user.email                 "mhartl@example.com"
  # user.password              "foobar"
  # user.password_confirmation "foobar"
 # end


# This will guess the User class
# FactoryGirl.define do
  # factory :user do
    # first_name "John"
    # last_name  "Doe"
    # admin false
  # end
 # end

  # # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
    # first_name "Admin"
    # last_name  "User"
    # admin      true
  # end
# end
