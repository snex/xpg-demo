class Invoice < ActiveResource::Base
  self.site = 'http://xpg.local:3000/api/v1'

  def self.create_invoice(order_id, nonce)
    invoice = Invoice.new(
      wallet_name:  'xpg-test',
      amount:       rand(1e10..10e12).to_i,
      external_id:  order_id,
      callback_url: "http://xpg-demo.xens.org/update_order_status/#{nonce}"
    )

    if invoice.save
      invoice
    else
      raise "couldnt save invoice"
    end
  end
end
