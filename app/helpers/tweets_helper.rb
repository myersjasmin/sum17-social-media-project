module TweetsHelper
	# def create
 #    message_arr = []
 #    @tweet = Tweet.new(tweet_params)

 #    message_arr = @tweet.message.split
 #    message_arr.each do |word, index|
 #      if word[0] == "#"
 #        if Tag.pluck (:phrase).include?(word)
 #          tag = Tag.find_by(phrase: word)
 #        else
 #          tag = Tag.create(phrase: word)
 #        end
 #        tweet_tag = TweetTag.creat(tweet_id: @tweet.id, tag_id: @tag.id)
 #        message_arr[index] = " <href='/tag_tweets?id=#{tag.id}'>#{word}>"
 #        tweet.update(message: message_arr.join (" "))
 #        end

        def get_tagged(tweet)
        	message_arr = []
        	message_arr = tweet.message.split

        	message_arr.each_with_index do |word, index|
        		if word[0] == "#"
        				if Tag.pluck(:phrase).include?(word)
        					tag = Tag.find_by(phrase: word)
        				else
        					tag = Tag.create(phrase: word)
        				end
        				tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        				message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
        end
			end
			 tweet.message = message_arr.join(" ")

			 return tweet
			end
		end

