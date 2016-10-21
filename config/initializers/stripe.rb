# Rails.configuration.stripe = {
#     :publishable_key => Rails.application.secrets.stripe_publishable_key,
#     :secret_key      => Rails.application.secrets.stripe_secret_key
# }
#
# Stripe.api_key = Rails.application.secrets.stripe_secret_key


Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
