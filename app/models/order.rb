class Order < ApplicationRecord
  belongs_to :user

  before_destroy { qr_code.purge }

  has_one_attached :qr_code

  def invoice_details
    @details ||= Invoice.find(xpg_invoice_id)
  rescue ActiveResource::ResourceNotFound
    nil
  end

  def qr_code_html
    return '' unless qr_code.attached?
    ActiveStorage::Current.url_options = { protocol: 'http', host: 'xpg-demo.xens.org' }
    HTTParty.get(qr_code.url)
  end

  def self.create_order(user)
    new_order_id = SecureRandom.uuid
    nonce = SecureRandom.uuid

    invoice = Invoice.create_invoice(new_order_id, nonce)

    new_order = Order.new(
      id:             new_order_id,
      user:           user,
      xpg_invoice_id: invoice.id,
      xpg_nonce:      nonce
    )
    new_order.save!

    new_order.qr_code.attach(io: StringIO.new(HTTParty.get(URI.parse(invoice.qr_code))), filename: "#{new_order_id}.svg")

    new_order
  end
end
