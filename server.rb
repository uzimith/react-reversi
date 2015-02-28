require 'sinatra'
require 'sinatra/rocketio'
set :public_folder, File.dirname(__FILE__)
set :cometio, :timeout => 120, :post_interval => 2, :allow_crossdomain => false
set :rocketio, :websocket => true, :comet => false


if development?
  require 'sinatra/reloader'
  set :bind, '0.0.0.0'
  set :port, 3000
  # set :logging, nil
end

get '/*' do |channel|
  @channel = channel
  erb :index
end

io = Sinatra::RocketIO

io.on 'connect' do |client|
  puts 'a user connected'
  p client
end

io.on 'disconnect' do |client|
  puts 'a user disconnected'
end

io.on 'create' do |_, client|
  begin
    name = 5.times.map { rand(10) }.join
  end while io.channels.keys.include?(name)
  puts "create : #{name}"
  io.push :join, name, to: client.session
end

io.on "join" do |name, client|
  puts "join : #{name}"
  io.push :join, name, to: client.session
end

io.on "action" do |data, client|
  puts "action"
  p data
  io.push :action, data, channel: client.channel
  # io.push :action, data, to: client.session
end
