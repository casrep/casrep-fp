#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'thin'
require 'json'
require 'mysql2'
require 'uri'

if ENV['VCAP_SERVICES']
	dbconf   = JSON.parse(ENV['VCAP_SERVICES'])
	dbconf   = dbconf['ctl_mysql'][0]['credentials']
	host     = dbconf['host']
	port     = dbconf['port']
	database = dbconf['name']
	username = dbconf['username']
	password = dbconf['password']
elsif ENV['DATABASE_URL']
	dbconf   = URI(ENV['DATABASE_URL'].split
	host     = dbconf[3]
	port     = dbconf[4]
	database = dbconf[6]
	userinfo = dbconf[2].split(":")
	username = userinfo[0]
	password = userinfo[1]
end

db = Mysql2::Client.new(
    host:      host,
    port:      port,
    database:  database,
    username:  username,
    password:  password,
    reconnect: true
)

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
