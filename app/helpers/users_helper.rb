module UsersHelper
	def url_esc(exp_time, picture_style, user)
		if !user.avatar.to_s.include?("missing.jpg")
			user.avatar.expiring_url(exp_time, picture_style)
		else
			user.avatar.url(picture_style)
		end
	end
end
