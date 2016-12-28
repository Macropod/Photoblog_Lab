module GalleriesHelper

	def galleries(user)
		if user.nil? 
			return Array.new
		end
		if user.admin == true
		  return Gallery.all
		elsif user.family == true
	      return Gallery.joins(:posts).where(:posts => {:family => true}).group("galleries.id")
	    elsif user.friends == true
	      return Gallery.joins(:posts).where(:posts => {:friends => true}).group("galleries.id")
	    elsif user.others == true
	      return Gallery.joins(:posts).where(:posts => {:others => true}).group("galleries.id")
      	else
      	  return Array.new
	    end
	end

	def galleries_grouped(galleries)
		current_year = nil
	    single_year_galleries = Array.new
	    grouped_galleries = Array.new
	    galleries.each do |gallery|
	      if(!gallery.start_date.nil?)
	        if gallery.start_date.year == current_year
	          single_year_galleries.push gallery
	        else
	          # save previous years selection of galleries
	          current_year = gallery.start_date.year
	          grouped_galleries.push single_year_galleries

	          # start new selection
	          single_year_galleries = Array.new
	          single_year_galleries.push gallery
	        end
	      end
	    end
	    grouped_galleries.push single_year_galleries
	    return grouped_galleries
	end
end