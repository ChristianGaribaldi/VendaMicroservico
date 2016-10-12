class CreateVendas < ActiveRecord::Migration
  def change
    create_table :vendas do |t|
      t.integer :produto_id
      t.integer :cliente_id
      t.integer :quantidade
      t.float :valorVenda
      t.string :tipo_pgt
      t.string :num_cartao
      t.string :validade_cartao
      t.string :codigo_cartao
      t.float :desconto

      t.timestamps null: false
    end
  end
end
