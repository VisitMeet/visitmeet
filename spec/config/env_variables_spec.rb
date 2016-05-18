# frozen_string_literal: true
# code: Environment variables such as SendGrid Keys and Passwords
# keys: config/local_env.yml : always ensure this is a .gitignore'd file
# test: spec/config/env_variables_spec.rb
# refs: Daniel Kehoe's article, Rails Environment Variables
# https://railsapps.io/env ??
require 'pry'
describe 'Environment variables' do
  describe 'SendGrid user_name' do
    # this tests env variables against config/secrets.yml which reads from your env variables $ env
    # to set this local env variable $ export SENDGRID_USERNAME=your_username
    # to set this heroku config variable in production $ heroku config:add SENDGRID_USERNAME=your_username
    # notice we can retrieve and test the keys in two ways
    it 'variable is set' do
binding.pry
      sendgrid_username = ENV.fetch('SENDGRID_USERNAME')
      expect(sendgrid_username).to eq(Rails.application.secrets.sendgrid_username),
        'Your SENDGRID_USERNAME is not set, Please refer to Rails Environment Variables'
      expect(ENV.fetch('SENDGRID_USERNAME')).to eq(Rails.application.secrets.sendgrid_username),
        'Your SENDGRID_USERNAME is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid password' do
    # to set this env variable $ export SENDGRID_PASSWORD=your_sendgrid_password
    # to set this heroku config variable in production $ heroku config:add SENDGRID_PASSWORD=your_sendgrid_password
    it 'variable is set' do
      expect(ENV['SENDGRID_PASSWORD']).to eq(Rails.application.secrets.sendgrid_password),
        'Your SENDGRID_PASSWORD is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid api_key' do
    # to set this env variable $ export SENDGRID_API_KEY=your_sendgrid_api_key
    # to set this heroku config variable in production $ heroku config:add SENDGRID_PASSWORD=your_sendgrid_api_key
    it 'variable is set' do
      expect(ENV['SENDGRID_API_KEY']).to eq(Rails.application.secrets.sendgrid_api_key),
        'Your SENDGRID_API_KEY is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid smtp password' do
    # to set this env variable $ export SENDGRID_SMTP_PASSWORD=your_sendgrid_smtp_password
    # to set this heroku config variable in production $ heroku config:add SENDGRID_SMTP_PASSWORD=your_sendgrid_smtp_password
    it 'variable is set' do
      expect(ENV['SENDGRID_SMTP_PASSWORD']).to eq(Rails.application.secrets.sendgrid_smtp_password),
        'Your SENDGRID_SMTP_PASSWORD is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid smtp username' do
    # to set this env variable $ export SENDGRID_SMTP_USERNAME=your_sendgrid_smtp_username
    # to set this heroku config variable in production $ heroku config:add SENDGRID_SMTP_USERNAME=your_sendgrid_smtp_username
    it 'variable is set' do
      expect(ENV['SENDGRID_SMTP_USERNAME']).to eq(Rails.application.secrets.sendgrid_smtp_username),
        'Your SENDGRID_SMTP_USERNAME is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SendGrid smtp address' do
    # this tests env variables against config/secrets.yml which reads from your env variables $ env
    # to set this local env variable $ export SMTP_ADDRESS=your_smtp_address
    # to set this heroku config variable in production $ heroku config:add SMTP_ADDRESS=your_smtp_address
    # notice we can retrieve and test the keys in two ways
    it 'variable is set' do
      api_key = ENV.fetch('SMTP_ADDRESS')
      expect(api_key).to eq(Rails.application.secrets.smtp_address),
        'Your SMTP_ADDRESS is not set, Please refer to Rails Environment Variables'
    end
  end

  describe 'SMTP domain' do
    # to set this env variable $ export SMTP_DOMAIN=your_smtp_domain
    # to set this heroku config variable in production $ heroku config:add SMTP_DOMAIN=your_smtp_domain
    it 'variable is set' do
      expect(ENV['SMTP_DOMAIN']).to eq(Rails.application.secrets.smtp_domain),
        'Your SMTP_DOMAIN is not set, Please refer to Rails Environment Variables'
    end
  end

  # describe 'PaperClip' do
  # it 'variables are set' do
  # # expect(config.paperclip_defaults).to be_an Array
  # # expect(config.paperclip_defaults.storage).to eq ':s3'
  # # expect(config.paperclip_defaults.storage[:s3_credentials].count).to eq 3
  # # expect(config.paperclip_defaults.storage[:s3_credentials][:bucket]).to eq "ENV['S3_BUCKET_NAME']"
  # # expect(config.paperclip_defaults.storage[:s3_credentials][:access_key_id]).to eq "ENV['AWS_ACCESS_KEY_ID']"
  # # expect(config.paperclip_defaults.storage[:s3_credentials][:secret_access_key]).to eq "ENV['AWS_SECRET_ACCESS_KEY']"
  # end
end
