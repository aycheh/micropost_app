require 'faker'

namespace :db do
  desc "Fill database with sample data"
    task :populate => :environment do
      Rake::Task['db:reset'].invoke
      user = User.create!(
                          :name => "asher ayche" , 
                          :email => "asher.aycheh@gmail.com" , 
                          :password => "foobar1" , 
                          :password_confirmation => "foobar1")
      99.times do |n|
       name = Faker::Name.name
       email= "example-#{n+1}@gmail.com"
       password = "password"
       User.create!(
                          :name => name , 
                          :email => email , 
                          :password => password , 
                          :password_confirmation => password)
      end                            
    end
end