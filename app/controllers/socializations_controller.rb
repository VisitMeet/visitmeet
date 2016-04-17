# frozen_string_literal: true
# app/controllers/socializations_controller.rb
class SocializationsController < ApplicationController
  include ActionController::Helpers

  before_action :load_socializable

  def follow
    current_user.follow!(@socializable)
    render json: { follow: true }
  end

  def unfollow
    current_user.unfollow!(@socializable)
    render json: { follow: false }
  end

  private

  def load_socializable
    @socializable = case
                    when id = params[:user_id]
                      User.find(id)
                    else
                      raise ArgumentError, 'Unsupported model, params:' + params.keys.inspect
                    end
    raise ActiveRecord::RecordNotFound unless @socializable
  end
end
