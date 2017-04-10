class AdicionarCamposAutenticacao < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :email, :string
    add_column :usuarios, :password_digest, :string
  end
end
