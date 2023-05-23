class Invoice < ActiveResource::Base
  self.site = "#{Rails.application.config.xpg_host}/api/v1"

  def self.create_invoice(order_id, nonce)
    invoice = Invoice.new(
      wallet_name:  'xpg-test',
      amount:       rand(1e10..10e12).to_i,
      external_id:  order_id,
      callback_url: "http://#{Rails.application.config.xpg_demo_host}:#{Rails.application.config.xpg_demo_port}/update_order_status/#{nonce}"
    )

    if invoice.save
      invoice
    else
      raise "couldnt save invoice: #{invoice.errors.inspect}"
    end
  end
end
