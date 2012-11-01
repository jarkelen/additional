module ApplicationHelper

  # Set the page title
  def set_page_title(title, extra_info)
    if extra_info
      page_title = title + ' (' + extra_info + ')'
	  else
		  page_title = title
	  end
	end
	
	# Formats a date field
	def friendly_date(date)
	  date.strftime('%d-%m-%Y')
	end
	
end