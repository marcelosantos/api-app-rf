class UsuariosController < ApplicationController
  skip_before_action :authorize_request, only: :create
  skip_before_action :authorize_request, only: :add

  # GET /usuarios
  def index
    if current_user.papel == 'auditor'
      usuarios = Usuario.all()
      json_response(usuarios)
    else
      json_response(current_user)
    end
  end

  # PUT /usuarios/:id
  def update
    @usuario = Usuario.find(params[:id])
    @usuario.update(user_params)
    head :no_content
  end

  # DELETE /usuarios/:id
  def destroy
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:usuario]
    if @current_user.papel == 'auditor'
      @usuario = Usuario.find(params[:id])
      @usuario.destroy
      head :no_content
    else
      response = { message: 'Você não tem essa permissão' }
      json_response(response, :unauthorized)
    end
  end

  # POST /usuarios/add
  def add
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:usuario]
    if @current_user.papel == 'auditor'
      usuario = Usuario.create!(user_params)
      json_response(usuario, :created)
    else
      response = { message: 'Você não tem essa permissão' }
      json_response(response, :unauthorized)
    end
  end

  # GET /usuarios/cem_mil
  def show
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:usuario]
    if @current_user.papel == 'auditor'
      usuarios = Usuario.select('usuarios.id,usuarios.nome,usuarios.email,usuarios.cidade,usuarios.endereco,SUM(bems.valor) AS soma_dos_bens')
                        .joins('INNER JOIN bems ON bems.usuario_id = usuarios.id')
                        .group('usuarios.id,usuarios.nome,usuarios.email,usuarios.cidade,usuarios.endereco')
                        .having('SUM(bems.valor) >= ?', 100000)

      usuarios_por_cidade = Usuario.select('COUNT(usuarios.id) AS total_cidadaos, usuarios.cidade')
                        .group('usuarios.cidade')
      response = { usuarios: usuarios, usuarios_por_cidade: usuarios_por_cidade }
      json_response(response, :created)
    else
      response = { message: 'Você não tem essa permissão' }
      json_response(response, :unauthorized)
    end
  end

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
