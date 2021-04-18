module UsersHelper
    def stripe_button_link
        stripe_url = "https://connect.stripe.com/express/oauth/authorize"
        redirect_uri = stripe_connect_url
        client_id = ENV["STRIPE_CLIENT_ID"]
      
       " https://connect.stripe.com/express/oauth/authorize?redirect_uri=https://buydeis.herokuapp.com/welcome&client_id=ca_JFZemHWKSNr3rpFjLgpSR3KmztvLfOKe&state={STATE_VALUE}"
       
      end
end
