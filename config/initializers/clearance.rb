Clearance.configure do |config|
  # config.mailer_sender = "reply@example.com"
  config.allow_sign_up = false
  config.cookie_domain = 'xpg-demo.xens.org'
  config.rotate_csrf_on_sign_in = true
  config.secure_cookie = true
  config.signed_cookie = true
end
