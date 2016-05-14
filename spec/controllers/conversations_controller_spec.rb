# frozen_string_literal: true
# code: app/controllers/conversations_controller.rb
# test: spec/controllers/conversations_controller_spec.rb
#
# Routes:
# # ??
# # ??
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
#
# include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe ConversationsController, :devise, js: true do
  before(:each) do
    @user = FactoryGirl.build(:user, email: 'admin@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'User can log in' do
    it 'renders the /users/profile view for User' do
      @user = FactoryGirl.build(:user, email: 'anyuser@example.com')
      @user.role = 'user'
      @user.save!
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)

      login_as(@user, scope: :user)
      expect(response.status).to eq 200
      expect(response).to be_success
    end
  end

  describe 'User converses ?' do
    pending 'figure it out and write a test or two'
    it 'does something, no clue what yet' do
      login_as(@user, scope: :user)
      expect(response.status).to eq 200
      expect(response).to be_success
      #
      # conversation methods : index, inbox, sentbox, trash, show, new, create
      # conversation routes  : from $ `rake routes`
      # #                    Prefix | Verb   | URI Pattern                                          | Controller#Action
      # #     conversation_messages | GET    |  /conversations/:conversation_id/messages(.:format)   | messages#index
      # #                           | POST   | /conversations/:conversation_id/messages(.:format)     | messages#create
      # #  new_conversation_message | GET   | /conversations/:conversation_id/messages/new(.:format)    | messages#new
      # # edit_conversation_message | GET  | /conversations/:conversation_id/messages/:id/edit(.:format) | messages#edit
      # #      conversation_message | GET   |  /conversations/:conversation_id/messages/:id(.:format) | messages#show
      # #                           | PATCH |  /conversations/:conversation_id/messages/:id(.:format) | messages#update
      # #                           | PUT   |  /conversations/:conversation_id/messages/:id(.:format) | messages#update
      # #                          | DELETE | /conversations/:conversation_id/messages/:id(.:format) | messages#destroy
      # #             conversations | GET    |  /conversations(.:format)                      | conversations#index
      # #                           | POST   |  /conversations(.:format)                      | conversations#create
      # #          new_conversation | GET    |  /conversations/new(.:format)                  | conversations#new
      # #         edit_conversation | GET    |  /conversations/:id/edit(.:format)             | conversations#edit
      # #              conversation | GET    |  /conversations/:id(.:format)                  | conversations#show
      # #                           | PATCH  |  /conversations/:id(.:format)                  | conversations#update
      # #                           | PUT    |  /conversations/:id(.:format)                  | conversations#update
      # #                           | DELETE |  /conversations/:id(.:format)                  | conversations#destroy
      #
    end

    context 'user have no existing conversation with another user' do
      it 'can create new conversation' do
      end
    end

    context 'user already have a conversation with another user' do
      it 'add new conversation to message' do
      end
    end
  end
end
