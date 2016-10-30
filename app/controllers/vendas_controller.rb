class VendasController < ApplicationController
  before_action :set_venda, only: [:show, :update, :destroy]

  # GET /vendas
  # GET /vendas.json
  def index
    @vendas = Venda.all

    render json: @vendas
  end

  # GET /vendas/1
  # GET /vendas/1.json
  def show
    render json: @venda
  end

  # POST /vendas
  # POST /vendas.json
  def create
    @venda = Venda.new(venda_params)

    if @venda.save
      atualiza_estoque_produto(@venda)
      render json: @venda, status: :created, location: @venda
    else
      render json: @venda.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vendas/1
  # PATCH/PUT /vendas/1.json
  def update
    @venda = Venda.find(params[:id])

    if @venda.update(venda_params)
      head :no_content
    else
      render json: @venda.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vendas/1
  # DELETE /vendas/1.json
  def destroy
    @venda.destroy

    head :no_content
  end

  private

  def set_venda
    @venda = Venda.find(params[:id])
  end

  def venda_params
    params.require(:venda).permit(:produto_id, :cliente_id, :quantidade, :valorVenda, :tipo_pgt, :num_cartao, :validade_cartao, :codigo_cartao, :desconto)
  end

  def atualiza_estoque_produto(venda)
    produto_micro = ProdutoMicroservico.new
    produto_venda = produto_micro.ler_produto(venda.produto_id)
    produto_venda.qtd_estoque -= venda.quantidade
    produto_micro.atualizar_produto(produto_venda)
  end
end
