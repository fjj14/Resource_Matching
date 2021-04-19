class StripeController < ApplicationController
    
  
    # Create stripe connect express account
    def create
      if current_user.stripe_user_id.nil?
          account = Stripe::Account.create({
                                             type: 'express',
                                             country: 'US',
                                           
                                             capabilities: {
                                               card_payments: {
                                                 'requested': true
                                               },
                                               transfers: { 'requested': true }
                                             }
                                           })
        # Store current users stripe id in user database
        current_user.stripe_user_id= account.id
  
        # Create temporary account link and redirect to express onboarding
        account_link = Stripe::AccountLink.create({
                                                    account: account.id,
                                                    refresh_url: 'https://buydeis.herokuapp.com/stripe/refresh/',
                                                    return_url: 'https://buydeis.herokuapp.com/stripe/returns/',
                                                    type: 'account_onboarding'
                                                  })
        redirect_to account_link.url
      else
        # Create temporary account link and redirect to express onboarding
        account_link = Stripe::AccountLink.create({
                                                    account: current_user.stripe_user_id,
                                                    refresh_url: 'https://buydeis.herokuapp.com/stripe/refresh/',
                                                    return_url: 'https://buydeis.herokuapp.com/stripe/returns/',
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
 
    
   
end