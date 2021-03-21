class MessagesController < ApplicationController
    before_action :set_conversation
    def create 
        receipt = User.where(id: session[:user_id]).first.reply_to_conversation(@conversation, params[:body])
        redirect_to conversation_path(receipt.conversation)
    end
    private 
    def set_conversation
        @conversation = User.where(id: session[:user_id]).first.mailbox.conversations.find(params[:conversation_id])
    end
end