class UsersController < ApplicationController
  before_action :authenticate_user!

  def premium_to_standard
    current_user.update_attributes(role: 'standard')

    privatewikis = current_user.wikis.where(private: true)
    privatewikis.each do |privatewiki|
      privatewiki.update_attributes(private: false)
    end

    flash[:notice] = "Your account, #{current_user.email} has been downgraded to Standard."
    redirect_to new_charge_path
  end
end
