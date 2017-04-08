class CreateUsuarios < ActiveRecord::Migration[5.0]
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.integer :sexo
      t.string :endereco
      t.integer :idade
      t.string :cidade
      t.string :papel

      t.timestamps
    end
  end
end
