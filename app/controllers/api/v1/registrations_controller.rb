class Api::V1::RegistrationsController < Devise::RegistrationsController
   # before_action :ensure_params_exist, only: :create

   def create
      user = User.new user_params
      if user.save
         json_response "Signed up successfully", true, { user: user }, :ok
      else
         json_response "Something wrong", false, {}, :unprocessable_entity
      end
   rescue StandardError => e
      json_response e.message, false, {}, :internal_server_error
   end

   private

   def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
   end

   # def ensure_params_exist
   #    return if params[:user].present?
   #    json_response "Missing params", false, {}, :bad_request
   # end
end