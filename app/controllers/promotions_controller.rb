class PromotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @promotions = Promotion.all
    # Se não for expor a variável promotions para a view, então não usamos o @. Como queremos expor ela para a views, então é necessário o @promotions
    # OBS: Toda Rota que for get, automaticamente dá render na view no final, e toda rota diferente de get, se não tiver nada dentro do método o Rails para a execução. Como o current_path fica observando a barra de endereço, se chamado um método e não tiver nada dentro dele e for diferente de GET, a rota será o próprio método que não fez nada. Ex: Chamou método Approve e ele está vazio, a rota ficará "/promotions/1/approve", pois ele parou de executar a aplicação no método approve.
    
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

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promtion = Promotion.find(params[:id])

    promotion_params = params.require(:promotion).permit(:name, :description, :code, :discount_rate, :coupon_quantity, :expiration_date)

    @promotion = Promotion.new(promotion_params)
    @promotion.user = current_user

    if @promotion.update(promotion_params)
      redirect_to @promotion
    else
      render :edit
    end
  end

  def destroy
    @promotion = Promotion.find(params[:id])
    @promotion.destroy

    redirect_to promotions_path
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])
    @promotion.generate_coupons!
    redirect_to @promotion, notice: t('.success')
  end

  def approve
    promotion = Promotion.find(params[:id])
    promotion.approve!(current_user)

    redirect_to promotion
  end
end