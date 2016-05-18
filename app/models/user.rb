# frozen_string_literal: true
# code : app/models/user.rb
# test : spec/models/user_spec.rb
# schema data last verified accurate 20160424 -ko
#
# == Schema Information
#
# Table name: users
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
class User < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_one :profile, dependent: :destroy
  enum role: [:admin, :user, :guide, :traveller]
  after_initialize :set_default_role, if: :new_record?

  # ref : https://github.com/intridea/omniauth/wiki/FAQ
  # User.connection
  # skip_before_filter :verify_authenticity_token, only: :create
  # causes error
  # `method_missing': undefined method `skip_before_filter' for User \
  # # (call 'User.connection' to establish a connection):Class (NoMethodError)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  # User can send message to each other.
  acts_as_messageable

  def set_default_role
    self.role ||= :user
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      #
      # ref for change :
      # http://www.rubydoc.info/github/plataformatec/devise/Devise.friendly_token
      length = 20
      user.password = Devise.friendly_token(length)
      # user.password = Devise.friendly_token[0, 20]
      #
      user.name = auth.info.name # user model has name
      # user.image = auth.info.image # users have no image.
      # # note.to.self : users rotating 'profile image' provided by ??
    end
  end

  # method found in config/initializers/mailboxer.rb
  # config.email_method = :mailboxer_email
  def mailboxer_email(*)
    nil
  end
end
