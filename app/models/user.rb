class User < ApplicationRecord
  include Clearance::User

  has_many :orders

  after_create :confirm_user

  def send_confirmation_email#deliver_confirmation_email
    # Do Nothing
    # or MyMailer.deliver_thank_you self
  end

  private

  def confirm_user
    confirm_email!
  end
end
