require 'rubygems'
require 'sinatra'
require 'thin'
# require 'mysql'

# begin
#   $db = Mysql.new('localhost', 'root', 'TaykMeeOn-55', 'local')
# rescue Mysql::Error
#   puts "Connection fall down, go boom."
#   exit 1
# end

# WOT Verification
get '/mywot*.html' do
	@wot = ENV['WOT']
end

get '/' do
	@title = "Home (CASREP)"
  erb :home
end

get '/interesting' do
	@title = "Interesting (CASREP)"
	erb :interesting
end

get '/projects' do
	@title = "Projects (CASREP)"
	erb :projects
end

get '/about' do
	@title = "About (CASREP)"
	erb :about
end

# get '/posts' do
# 	@results = $db.query("SELECT * FROM posts")
# end
