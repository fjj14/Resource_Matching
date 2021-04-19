class StripeController < ApplicationController
    def connect
        response = HTTParty.post("https://connect.stripe.com/oauth/token",
        query: {
          client_secret: ENV["STRIPE_SECRET_KEY"],
          code: {AUTHORIZATION_CODE},
          grant_type: "authorization_code"
        }
      )
       
        if response.parsed_response.key?("error")
            redirect_to welcome_path,
            notice: response.parsed_response["error_description"]
        else
            stripe_user_id = response.stripe_user_id
            current_user.stripe_user_id = stripe_user_id
            redirect_to mypage_path,
            notice: 'User successfully connected with Stripe!'
        end
    end
end