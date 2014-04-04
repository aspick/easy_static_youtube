require "easy_static_youtube/version"
require 'rubygems'
require 'net/http'
require 'json'

module EasyStaticYoutube

	def self.api_key=(key)
		@@api_key = key
	end

	def self.get_metadata(video_id)
		baseURL = 'https://www.googleapis.com/youtube/v3/videos'
		requestURL = "#{baseURL}?id=#{video_id}&key=#{@@api_key}&part=snippet&fields=items(id,snippet)"
		response = Net::HTTP.get_response(URI.parse(requestURL))
		return JSON.parse(response.body)["items"].first
	end

end

