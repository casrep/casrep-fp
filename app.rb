require 'sinatra'
require 'thin'

# WOT Verification
get '/mywot*.html' do
	@wot = ENV['WOT']
end

get '/' do
	@title = "The Casualty Report"
  erb :home
end

get '/projects' do
	@title = "Derek's Projects"
	erb :projects
end

get '/about' do
	@title = "About Derek"
	erb :about
end
