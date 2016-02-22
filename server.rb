require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end

post '/create_payment' do
  # Set your secret key: remember to change this to your live secret key in production
  # See your keys here https://dashboard.stripe.com/account/apikeys
  Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"

  # Get the credit card details submitted by the form
  token = params[:stripeToken]

  # Create a Customer
  customer = Stripe::Customer.create(
    :source => token,
    :description => "Example customer"
  )

  # Charge the Customer instead of the card
  begin
    charge = Stripe::Charge.create(
        :amount => 1000, # in cents
        :currency => "usd",
        :customer => customer.id,
        :metadata => {
          "order_id" => "6735",
          "referral_page" => "",
          "location" =>,
        }
    )
  rescue Stripe::CardError => e
    # The card has been declined
  end
  # YOUR CODE: Save the customer ID and other info in a database for later
end

post '/add_subscriber' do
# Set your secret key: remember to change this to your live secret key in production
# See your keys here https://dashboard.stripe.com/account/apikeys
  Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"

  # Get the credit card details submitted by the form
  token = params[:stripeToken]

  # Create a Customer
  customer = Stripe::Customer.create(
    :source => token,
    :plan => "gold",
    :email => "payinguser@example.com"
  )
end
