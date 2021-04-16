class MessagesController < ApplicationController
    before_action :set_conversation
    def create 
        receipt = User.where(id: session[:user_id]).first.reply_to_conversation(@conversation, params[:body])
        redirect_to conversation_path(receipt.conversation)
        users_mes = @conversation.participants
        if users_mes[0].id == session[:user_id]
            users_mes[1].notify("hi" "#{users_mes[0].first} #{users_mes[0].last} sent you a message")
        else 
            users_mes[0].notify("hi"," #{users_mes[1].first} #{users_mes[1].last} sent you a message")
        end
    end
    private 
    def set_conversation
        @conversation = User.where(id: session[:user_id]).first.mailbox.conversations.find(params[:conversation_id])
    end
end