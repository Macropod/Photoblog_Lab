module UsersHelper
	def url_esc_user(exp_time, picture_style, object)
		if !object.avatar.to_s.include?("missing.jpg")
			object.avatar.expiring_url(exp_time, picture_style)
		else
			object.avatar.url(picture_style)
		end
	end
end
