class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
  def authenticate
    auth_token = AuthenticateUsuario.new(auth_params[:email], auth_params[:password]).call
    logado = Usuario.find_by(email: auth_params[:email])
    json_response(auth_token: auth_token, logado: logado)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
