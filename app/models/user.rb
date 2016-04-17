# frozen_string_literal: true
# code : app/models/user.rb
# test : spec/models/user_spec.rb : passing 20160415 kathyonu
# the following was last verified accurate 20160415 kathyonu
# # see db/schema.db for current user attribute contraints
# # [User(
# #   id: integer,
# #   email: string,
# #   encrypted_password: string,
# #   reset_password_token: string,
# #   reset_password_sent_at: datetime,
# #   remember_created_at: datetime,
# #   sign_in_count: integer,
# #   current_sign_in_at: datetime,
# #   last_sign_in_at: datetime,
# #   current_sign_in_ip: inet,
# #   last_sign_in_ip: inet,
# #   created_at: datetime,
# #   updated_at: datetime,
# #   name: string,
# #   confirmation_token: string,
# #   confirmed_at: datetime,
# #   confirmation_sent_at: datetime,
# #   unconfirmed_email: string,
# #   role: integer,
# #   invitation_token: string,
# #   invitation_created_at: datetime,
# #   invitation_sent_at: datetime,
# #   invitation_accepted_at: datetime,
# #   invitation_limit: integer,
# #   invited_by_id: integer,
# #   invited_by_type: string,
# #   invitations_count: integer,
# #   provider: string,
# #   uid: string
# # )]
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
      # ref for change : http://www.rubydoc.info/github/plataformatec/devise/Devise.friendly_token
      user.password = Devise.friendly_token(length = 20)
      # user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # user model has name
      # user.image = auth.info.image # users have no image.
      # # note.to.self : users rotating 'profile image' provided by ??
    end
  end
end
