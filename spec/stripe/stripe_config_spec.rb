# frozen_string_literal: true
# code: to be listed when stripe is installed
# test: spec/stripe/strpe_config_spec.rb
describe 'Config Variables' do
  describe 'STRIPE_API_KEY' do
    # this tests env variables against config/secrets.yml which reads from your env variables $ env
    # to set this env variable $ export STRIPE_API_KEY=yourverylongStripApiKey
    # to set this heroku config variable in production $ heroku config:add STRIPE_API_KEY=sk_live_yourlongstring
    # notice we can retrieve and test the keys in two ways
    # it 'a stripe api key is set' do
    #  api_key = ENV.fetch('STRIPE_API_KEY')
    #  expect(api_key).to eq(Rails.application.secrets.stripe_api_key),
    #    'Your STRIPE_API_KEY is not set, Please refer to the "Configure the Stripe Initializer" section of the README'
    # end
  end

  describe 'STRIPE_PUBLISHABLE_KEY' do
    # to set this env variable $ export STRIPE_PUBLISHABLE_KEY=yourverylongStripPublishableKey
    # to set this heroku config variable in production $ heroku config:add STRIPE_PUBLISHABLE_KEY=pk_live_yourlongstring
    # it 'a STRIPE_PUBLISHING_KEY is set' do
    #   expect(ENV['STRIPE_PUBLISHABLE_KEY']).to eq(Rails.application.secrets.stripe_publishable_key),
    #    'Your STRIPE_PUBLISHABLE_KEY is not set, Please refer to the "Configure the Stripe Initializer" section of the README'
    # end
  end
end
