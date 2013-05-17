module GalleriesHelper

	def galleries(user)
		if user.nil? 
			return Array.new
		end
		if user.admin == true
		  return Gallery.all
		elsif user.family == true
	      return Gallery.joins(:posts).where(:posts => {:family => true}).group('galleries.id')
	    elsif user.friends == true
	      return Gallery.joins(:posts).where(:posts => {:friends => true}).group('galleries.id')
	    elsif user.others == true
	      return Gallery.joins(:posts).where(:posts => {:others => true}).group('galleries.id')
      	else
      	  return Array.new
	    end
	end
end