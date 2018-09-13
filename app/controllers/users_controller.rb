class UsersController < ApplicationController
  def premium_to_standard
    current_user.update_attributes(role: 'standard')
    flash[:notice] = "Your account, #{current_user.email} has been downgraded to Standard."
    redirect_to new_charge_path
  end
end
