module UsersHelper
	def gravatar_for user
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		if user.picture?
			gravatar_url = user.picture.url
			image_tag(gravatar_url, alt: user.name, class: "gravatar")
		else
			gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
			image_tag(gravatar_url, alt: user.name, class: "gravatar")
		end
	end
end
