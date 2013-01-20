module ApplicationHelper

	def full_title(page_title)
		base_title = "PhotoBlog"
		if !page_title.nil?
			if page_title.empty?
				base_title
			else
				"#{base_title} | #{page_title}"
			end
		else
			base_title
		end
	end
	
end
