#require "easy_static_youtube/version"
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

	def self.get_video_id_from_youtube_url(url)
		query = URI.parse(url).query
		param_lines = query.split('&')
		params = {}
		param_lines.each do |line|
			kv = line.split('=')
			params[kv[0]] = kv[1]
		end
		return params['v']
	end

	def self.get_playlist_metadata(playlist_id)
		baseURL = 'https://www.googleapis.com/youtube/v3/playlists'
		requestURL = "#{baseURL}?id=#{playlist_id}&key=#{@@api_key}&part=snippet&fields=items(id,snippet)"
		response = Net::HTTP.get_response(URI.parse(requestURL))
		return JSON.parse(response.body)["items"].first
	end

	def self.get_playlist_id_from_youtube_url(url)
		query = URI.parse(url).query
		param_lines = query.split('&')
		params = {}
		param_lines.each do |line|
			kv = line.split('=')
			params[kv[0]] = kv[1]
		end
		return params['list']
	end

end

EasyStaticYoutube.api_key = 'AIzaSyAGCnmsWIzwzUhrSTuKJV79vow_-q5bJes'
puts EasyStaticYoutube.get_palylist_metadata('PLPAkf8CmoCaycpEqwyp3Zz99ZTiElFVEP')

