class UsersController < ApplicationController
  after_action :create_authy_id, only: [:update]

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  # create authy_id for a user to be verifiable on Twilio
  def create_authy_id
    authy = Authy::API.register_user(
      email: current_user.email,
      cellphone: current_user.phone_number,
      country_code: current_user.country_code
    )

    current_user.update(
      authy_id: authy.id
    )
  end

  def user_params
    params.require(:user).permit(
      :phone_number, :full_name, :country_code
    )
  end
end
