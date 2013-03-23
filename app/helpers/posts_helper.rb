module PostsHelper
	def url_esc_post(exp_time, picture_style, object)
		if !object.picture.to_s.include?("missing.jpg")
			object.picture.expiring_url(exp_time, picture_style)
		else
			object.picture.url(picture_style)
		end
	end

	def correct_group?(post)
		if post.family == true && current_user.family == true
			return true
		elsif post.friends == true && current_user.friends == true
			return true
		elsif post.others == true && current_user.others == true
			return true
		elsif current_user.admin?
			return true
		else
			return false
		end
	end
end