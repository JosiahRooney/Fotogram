module PostsHelper
	def display_likes(post)
		votes = post.votes_for.up.by_type(User)
		if votes.size <= 8
			return list_likers(votes)
		else
			count_likers(votes)
		end
	end

	def liked_post(post)
		if current_user.voted_for? post
			return 'glyphicon-heart'
		else
			return 'glyphicon-heart-empty'
		end 
	end

	def likers_of(post)
		votes = post.votes_for.up.by_type(User)
		user_names = []
		unless votes.blank?
			votes.voters.each do |voter|
				user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: 'user-name')
			end
			user_names.to_sentence.html_safe + like_plural(votes)
		end
	end

	private

	def list_likers(votes)
		user_names = []
		unless votes.blank?
			votes.voters.each do |voter|
				user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: 'user-name')
			end
			user_names.to_sentence.html_safe + like_plural(votes)
		end
	end

	def count_likers(votes)
		vote_count = votes.size
		vote_count.to_s + ' likes'
	end

	def like_plural(votes)
		return ' like this' if votes.count > 1
		' likes this'
	end
end