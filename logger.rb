require 'sinatra'

get '/' do
  send_file File.join('log', 'development.log')
end
