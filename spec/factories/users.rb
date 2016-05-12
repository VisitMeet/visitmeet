# frozen_string_literal: true
# spec/factories/users.rb
# tests: spec/features/users/
#
# Migrations affectin Users
#
# db/migrate/20160115121043_devise_create_users.rb
# db/migrate/20160115121047_add_name_to_users.rb
# db/migrate/20160115121051_add_confirmable_to_users.rb
# db/migrate/20160115121058_add_role_to_users.rb
# db/migrate/20160115121151_devise_invitable_add_to_users.rb
# db/migrate/20160118081841_create_products.rb
# db/migrate/20160125172412_add_omniauth_to_users.rb
# db/migrate/20160303161926_create_profiles.rb
#
# == Schema Information
#
# Table name: users : attributes last verified accurate 20160405 -ko
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  provider               :string
#  uid                    :string
#
FactoryGirl.define do
  # after(:build) { |object| puts "Built #{object}" }
  # after(:create) { |object| puts "Object attributes:: #{object.attributes}" }
  # after(:create) { |object| AuditLog.create(attrs: object.attributes) }

  factory :user do
    name 'Test User'
    email 'test@example.com'
    password 'please123'
    confirmed_at Time.current

    trait :admin do
      role 'admin'
    end
  end
end
