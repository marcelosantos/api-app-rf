class AuthenticateUsuario
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: usuario.id) if usuario
  end

  private

    attr_reader :email, :password

    # verify usuario credentials
    def usuario
      usuario = Usuario.find_by(email: email)
      return usuario if usuario && usuario.authenticate(password)
      # raise Authentication error if credentials are invalid
      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end
