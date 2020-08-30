class CreateEscolas < ActiveRecord::Migration[5.2]
  def change
    create_table :escolas do |t|
      t.string :nome
      t.string :endereco
      t.integer :numero
      t.string :bairro
      t.string :cidade
      t.string :responsavel
      t.string :telefone

      t.timestamps
    end
  end
end
