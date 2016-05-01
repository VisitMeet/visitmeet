# Conversations Controller
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
