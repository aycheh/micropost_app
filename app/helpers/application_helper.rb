module ApplicationHelper
   # Return a title on a per-page basis.
   def title
     base_title = "Ruby On Rails tutorial micropost_app"
     if @title.nil?
       base_title
     else
       "#{base_title} | #{@title}"
     end
   end
   
   def logo 
     image_tag("mishpaha_logo.gif" , :alt => "Micropost App" , :class => "round") 
   end 
end
