class Venda < ActiveRecord::Base
  validates :produto_id, presence: { message: "Selecione o Produto." }
  validates :cliente_id, presence: { message: "Selecione o Cliente." }
  validates :quantidade, presence: { message: "Selecione a quantidade." }
  validates :valorVenda, presence: true

  validate :qtd_venda
  validate :valida_produto
  validate :valida_cliente

  def qtd_venda
    # errors.add(:base, "A venda para o produto #{produto.nome} não foi realizada: estoque (#{produto.qtd_estoque} itens) insuficiente para a venda") if quantidade > produto.qtd_estoque
  end

  def valida_produto

  end

  def valida_cliente

  end
end
