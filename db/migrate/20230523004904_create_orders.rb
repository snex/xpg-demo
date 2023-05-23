class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'

    create_table :orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true
      t.string :xpg_invoice_id, null: false
      t.string :xpg_nonce, null: false
      t.string :status, null: false, default: 'new'

      t.timestamps
    end
  end
end
