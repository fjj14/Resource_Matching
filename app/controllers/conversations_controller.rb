class ConversationsController < ApplicationController
    def index
        @conversations = User.where(id: session[:user_id]).first.mailbox.conversations
    end
    def show 
        @conversation = User.where(id: session[:user_id]).first.mailbox.conversations.find(params[:id])
        @conversations = User.where(id: session[:user_id]).first.mailbox.conversations
    end 
    def new
        @recipients = User.all - [User.where(id: session[:user_id]).first]
    end
    def create
        recipient = User.find(params[:user_id])
        receipt = User.where(id: session[:user_id]).first.send_message(recipient, params[:body], params[:subject])
        redirect_to conversation_path(receipt.conversation)
    end

end