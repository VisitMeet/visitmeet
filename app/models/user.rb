# frozen_string_literal: true
# see db/schema.db for user attributes
class User < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_one :profile, dependent: :destroy

  enum role: [:admin, :user, :guide, :traveller]
  after_initialize :set_default_role, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  def set_default_role
    self.role ||= :user
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # user model has name
      # user.image = auth.info.image #user have no image.
    end
  end
end
