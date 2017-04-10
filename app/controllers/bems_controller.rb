class BemsController < ApplicationController
  before_action :set_usuario
  before_action :set_usuario_bem, only: [:show, :update, :destroy]

  # GET /usuarios/:usuario_id/bems
  def index
    json_response(@usuario.bems)
  end

  # GET /usuarios/:usuario_id/bems/:id
  def show
    json_response(@bem)
  end

  # POST /usuarios/:usuario_id/bems
  def create
    @usuario.bems.create!(bem_params)
    json_response(@usuario, :created)
  end

  # PUT /usuarios/:usuario_id/bems/:id
  def update
    @bem.update(bem_params)
    head :no_content
  end

  # DELETE /usuarios/:usuario_id/bems/:id
  def destroy
    @bem.destroy
    head :no_content
  end

  private

  def bem_params
    params.permit(:nome, :tipo, :valor)
  end

  def set_usuario
    @usuario = Usuario.find(params[:usuario_id])
  end

  def set_usuario_bem
    @bem = @usuario.bems.find_by!(id: params[:id]) if @usuario
  end

end
