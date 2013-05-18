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

	def date_interval(start_date, end_date)
		return "" if start_date.nil? || end_date.nil?

		year1 = start_date.year
		year2 = end_date.year
		month1 = start_date.month
		month2 = end_date.month 
		day1 = start_date.day 
		day2 = end_date.day 

		if year1 == year2
			if month1 == month2
				if day1 == day2
					return "#{day1} #{end_date.strftime('%b')} #{year1}"
				else
					return "#{day1} - #{day2} #{end_date.strftime('%b')} #{year1}"
				end
			else
				return "#{day1} #{start_date.strftime('%b')} - #{day2} #{end_date.strftime('%b')} #{year1}"
			end
		else
			return "#{day1} #{start_date.strftime('%b')} #{year1} - #{day2} #{end_date.strftime('%b')} #{year2}"
		end
	end

end
