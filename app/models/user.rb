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
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # User can send message to each other.
  acts_as_messageable

  def set_default_role
    self.role ||= :user
  end

  def mailboxer_email(*)
    nil
  end
end
