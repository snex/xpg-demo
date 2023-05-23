require 'active_resource'
#require 'httplog'

ActiveResource::Base.logger = Logger.new(STDERR)

class Invoice < ActiveResource::Base
  self.site = 'http://xpg.local:3000/api/v1'
end

invoice = Invoice.find(ARGV[0])

puts invoice.attributes.inspect
