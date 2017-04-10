class CreateBems < ActiveRecord::Migration[5.0]
  def change
    create_table :bems do |t|
      t.string :nome
      t.integer :tipo
      t.decimal :valor
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
