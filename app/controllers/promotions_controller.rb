class PromotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @promotions = Promotion.all
    # Se não for expor a variável promotions para a view, então não usamos o @. Como queremos expor ela para a views, então é necessário o @promotions

  end

  def show
    id = params[:id]
    @promotion = Promotion.find(id)
  end

  def new
    @promotion = Promotion.new
  end

  def create
    # Strong Parameters abaixo
    promotion_params = params.require(:promotion).permit(:name, :description, :code, :discount_rate, :coupon_quantity, :expiration_date)

    # Melhorar este código com parâmetros fortes, está no guia rails 
    # @promotion.name = params[:promotion][:name]
    # @promotion.description = params[:promotion][:description]
    # @promotion.code = params[:promotion][:code]
    # @promotion.discount_rate = params[:promotion][:discount_rate]
    # @promotion.coupon_quantity = params[:promotion][:coupon_quantity]
    # @promotion.expiration_date = params[:promotion][:expiration_date]

    @promotion = Promotion.new(promotion_params)
    @promotion.user = current_user #Linha que vincula um objeto a um usuário
    if @promotion.save
      # Save faz 2 coisas
      #   1º - Executa todas validações configuradas no model
      #   2º - Envia um comando SQL pro banco de dados e faz o INSERT
      #   Se tudo Ok -> true
      redirect_to @promotion
    else
      render 'new'
    end
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])

    @promotion.generate_coupons!
    flash[:notice] = t('.success')
    redirect_to @promotion
  end
end