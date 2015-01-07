require 'sinatra'
require 'thin'
require 'haml'

# WOT Verification
get '/mywot*.html' do
	@wot = ENV['WOT']
end

get '/' do
	@title = "The Casualty Report"
  haml :home
end

get '/projects' do
	@title = "Derek's Projects"
	haml :projects
end

get '/about' do
	@title = "About Derek"
	haml :about
end

get '/test' do
	@title = "Testing"
	haml :test
end