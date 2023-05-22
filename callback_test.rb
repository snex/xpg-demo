require 'json'
require 'sinatra'

post '/:callback' do
  puts params.inspect
  puts JSON.parse(request.body.read)
end
