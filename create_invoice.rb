require 'active_resource'
#require 'httplog'

ActiveResource::Base.logger = Logger.new(STDERR)

class Invoice < ActiveResource::Base
  self.site = 'http://xpg.local:3000/api/v1'
end

invoice = Invoice.new(
  wallet_name:  'xpg-test',
  amount:       1e12.to_i,
  external_id:  SecureRandom.hex,
  callback_url: "http://host.docker.internal:4567/#{SecureRandom.hex}"
)

if invoice.save
  puts invoice.attributes.inspect
else
  puts invoice.errors.full_messages.inspect
end
