module ApplicationHelper

  def full_title(page_title)
    unless page_title.empty?
      "Fitness Schedules | #{page_title}" 
    else
      "Fitness Schedules"
    end
  end
  
end
