class StripeController < ApplicationController
    
  
    # Create stripe connect express account
    def create
      if current_user.stripe_user_id.nil?
          account = Stripe::Account.create({
                                             type: 'express',
                                             country: 'US',
                                             email: `#{current_user.email}`,
                                             capabilities: {
                                               card_payments: {
                                                 'requested': true
                                               },
                                               transfers: { 'requested': true }
                                             }
                                           })
        # Store current users stripe id in user database
        current_user.update_column(:stripe_user_id, account.id)
  
        # Create temporary account link and redirect to express onboarding
        account_link = Stripe::AccountLink.create({
                                                    account: account.id,
                                                    refresh_url: 'https://buydeis.herokuapp.com?/account/refresh/',
                                                    return_url: 'https://buydeis.herokuapp.com?/account/returns/',
                                                    type: 'account_onboarding'
                                                  })
        redirect_to account_link.url
      else
        # Create temporary account link and redirect to express onboarding
        account_link = Stripe::AccountLink.create({
                                                    account: current_user.stripe_user_id,
                                                    refresh_url: 'https://product-marketplace-mh001v.herokuapp.com/account/refresh/',
                                                    return_url: 'https://product-marketplace-mh001v.herokuapp.com/account/returns/',
                                                    type: 'account_onboarding'
                                                  })
        redirect_to account_link.url
      end
    end
  
    def refresh
        
    end
  
    def returns; end
  
    # If current user stripe account token stored on platform, create a link to the express dashboard
    def stripe_dashboard
      dashboard_link = Stripe::Account.create_login_link(current_user.stripe_user_id)
      redirect_to dashboard_link.url
    end
 
    
    def connect
        response = HTTParty.get("https://connect.stripe.com/oauth/token",
        query: {
          client_secret: ENV["STRIPE_SECRET_KEY"],
          code: params[:code],
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