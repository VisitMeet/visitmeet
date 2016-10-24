# Rails.configuration.stripe = {
#     :publishable_key => Rails.application.secrets.stripe_publishable_key,
#     :secret_key      => Rails.application.secrets.stripe_secret_key
# }
#
# Stripe.api_key = Rails.application.secrets.stripe_secret_key


Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_API_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
