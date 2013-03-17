module PostsHelper
	def url_esc_post(exp_time, picture_style, object)
		if !object.picture.to_s.include?("missing.jpg")
			object.picture.expiring_url(exp_time, picture_style)
		else
			object.picture.url(picture_style)
		end
	end
end