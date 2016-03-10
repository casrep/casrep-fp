#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'thin'
require 'json'
require 'mysql2'

if ENV['VCAP_SERVICES']
	dbconf = JSON.parse(ENV['VCAP_SERVICES'])
	dbconf = dbconf['ctl_mysql'][0]['credentials']
	#dbhost = dbconf["host"]
	#dbport = dbconf["port"]
	#dbname = dbconf["dbname"]
	#dbuser = dbconf["uname"]
	#dbpass = dbconf["pword"]

	db = Mysql2::Client.new(
	    host:      dbconf['host'],
	    port:      dbconf['port'],
	    database:  dbconf['name'],
	    username:  dbconf['username'],
	    password:  dbconf['password'],
	    reconnect: true
	)
end

# WOT Verification
get '/mywot*.html' do
	@wot = ENV['WOT']
end

get '/' do
	@title   = 'Home (CASREP)'
	@page    = 'Home'
	db.query("SELECT data FROM content WHERE name = 'home-general'").each do |result|
		@general = result['data']
	end
	erb :home
end

get '/toi' do
	@title   = 'Interesting (CASREP)'
	@page    = 'Things of Interest'
	erb :toi
end

get '/about' do
	@title   = 'About (CASREP)'
	@page    = 'About'
	db.query("SELECT data FROM content WHERE name = 'about-general'").each do |result|
		@general = result['data']
	end
	erb :about
end
