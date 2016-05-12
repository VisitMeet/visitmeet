# frozen_string_literal: true
# code: app/controllers/conversations_controller.rb
# test: spec/controllers/conversations_controller_spec.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller_spec.rb
#
# These are Functional Tests for Rail Controllers testing the
# various actions of a single controller. Controllers handle the
# incoming web requests to your application and eventually respond
# with a rendered view.
#
class ConversationsController < ApplicationController
  # get conversations for the current user
  def index
    @conversations = current_user.mailbox.conversations
  end

  def inbox
    @incoming_messages = current_user.mailbox.inbox
  end

  def sentbox
    @sent_messages = current_user.mailbox.sentbox
  end

  def trash
    @deleted_messages = current_user.mailbox.trash
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @recipients = User.all - [current_user]
  end

  def create
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, params[:body], params[:subject])
    redirect_to conversations_path(receipt.conversation)
  end
end
