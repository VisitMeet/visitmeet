# frozen_string_literal: true
# code: app/controllers/messages_controller.rb
# test: spec/controllers/messages_controller_spec.rb
#
# Controller for messages
# Messages belong to conversations
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    receipt = current_user.reply_to_conversation(@conversation, params[:body])
    redirect_to conversation_path(receipt.conversation)
  end

  private

  def set_conversation
    @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
  end
end
