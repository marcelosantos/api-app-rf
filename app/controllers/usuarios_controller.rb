class UsuariosController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    user = Usuario.create!(user_params)
    auth_token = AuthenticateUsuario.new(#user.nome,
                                        #user.sexo, user.endereco,
                                        #user.cidade, user.papel,
                                        user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :nome,
      :sexo,
      :endereco,
      :idade,
      :cidade,
      :papel,
      :email,
      :password,
      :password_confirmation
    )
  end
end
