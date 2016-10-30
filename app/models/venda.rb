require 'produto_microservico'
require 'cliente_microservico'

class Venda < ActiveRecord::Base
  validates :produto_id, presence: { message: "Selecione o Produto." }
  validates :cliente_id, presence: { message: "Selecione o Cliente." }
  validates :quantidade, presence: { message: "Selecione a quantidade." }
  validates :valorVenda, presence: true

  validate :valida_produto_qtd_venda
  validate :valida_cliente

  def valida_produto_qtd_venda
    produto_micro = ProdutoMicroservico.new
    produto_venda = produto_micro.ler_produto(produto_id)

    venda_possivel =  !produto_venda.nil? && !quantidade.nil? && quantidade <= produto_venda.qtd_estoque
    errors.add(:base, "A venda para o produto #{produto_venda.nome} não foi realizada: estoque (#{produto_venda.qtd_estoque} itens) insuficiente para a venda") if !venda_possivel
  end

  def valida_cliente
    cliente_micro = ClienteMicroservico.new
    errors.add(:base, "A venda não foi realizada: Cliente inexistente!") if cliente_micro.ler_cliente(cliente_id).nil?
  end
end
