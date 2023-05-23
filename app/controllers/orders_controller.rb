class OrdersController < ApplicationController
  before_action :require_login, except: :update_order_status
  before_action :set_order, only: %i[ show destroy ]
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end
  skip_before_action :verify_authenticity_token, only: :update_order_status

  # GET /orders
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.create_order(current_user)

    redirect_to @order
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: "Order was successfully destroyed."
  end

  def update_order_status
    @order = Order.find_by(xpg_nonce: params[:nonce])
    new_status = params[:status]

    if new_status == 'payment_witnessed'
      new_status = "#{params[:status]} (#{params[:confirmations].to_i}/#{params[:necessary_confirmations]} confirms)"
    end

    @order.update(status: new_status)
    @order.qr_code.purge
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
