class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
        :key => Rails.configuration.stripe[:publishable_key].to_s,
        :description => "Blocipedia Premium - #{current_user.email}",
        :amount => 1500
    }
  end

  def create
    @amount = 1500

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => "Blocipedia Premium - #{current_user.email}",
      :currency => 'usd'
    )

    current_user.update_attribute(:role, 'premium')
    redirect_to root_path(current_user)
    flash[:notice] = "Your account, #{current_user.email} has been updated to Premium."

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
end
