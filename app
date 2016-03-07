#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'thin'
require 'json'
require 'pg'

begin
	dbconf = File.read('config/db.json')
	dbconf = JSON.parse(dbconf)
	dbhost = dbconf['host']
	dbport = dbconf['port']
	dbname = dbconf['name']
	dbuser = dbconf['user']
	dbpass = dbconf['pass']

	db = PG::connect(
	    host:     dbhost,
	    port:     dbport,
	    user:     dbuser,
	    password: dbpass,
	    dbname:   dbname
	)
end

# WOT Verification
get '/mywot*.html' do
	@wot = ENV['WOT']
end

get '/' do
	@title   = 'Home (CASREP)'
	@page    = 'Home'
	@general = db.exec("SELECT data FROM content WHERE name = 'home-general'").getvalue(0,0)
	erb :home
end

get '/toi' do
	@title   = 'Interesting (CASREP)'
	@page    = 'Things of Interest'
	@general = db.exec("SELECT data FROM content WHERE name = 'toi-general'").getvalue(0,0)
	erb :toi
end

get '/about' do
	@title   = 'About (CASREP)'
	@page    = 'About'
	@general = db.exec("SELECT data FROM content WHERE name = 'about-general'").getvalue(0,0)
	erb :about
end
