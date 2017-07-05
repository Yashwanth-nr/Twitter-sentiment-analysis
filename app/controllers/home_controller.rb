class HomeController < ApplicationController

	def search
	end
	
	def results
		

		hashtag = params[:hashtag]
		
		client = Twitter::REST::Client.new do |config|
  			config.consumer_key    = "x7c3DFMOQXA07lwqZanlmldHm"
  			config.consumer_secret = "tZMM1seBbjgK1TCzTqziFkgri4kSlddWQ2SQg0A5NkQL5pSBRy"
  		end
		analyzer = Sentimental.new
		analyzer.load_defaults
		analyzer.load_senti_file('/home/yash/rails-jan/rails/twitter/app/controllers/home_controller.rb')

		@output = {"positive" => 0,"neutral" => 0,"negative" => 0}
		client.search("##{hashtag}", :result_type => "recent").collect do |tweet|

 			senti = analyzer.sentiment "#{tweet.text}"

				 if senti.to_s == "positive"
				 	@output["positive"] += 1
				 elsif senti.to_s == "negative"
				 	@output["negative"] += 1
				 elsif senti.to_s == "neutral"
				 	@output["neutral"] += 1
				 end
		end

	
		
			
	end

end
