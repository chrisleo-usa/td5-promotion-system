class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
    # Se não for expor a variável promotions para a view, então não usamos o @. Como queremos expor ela para a views, então é necessário o @promotions

  end

  def show
    id = params[:id]
    @promotion = Promotion.find(id)
  end

  def new

  end
  def create
    @promotion = Promotion.new

    @promotion.name = params[:promotion][:name]
    @promotion.description = params[:promotion][:description]
    @promotion.code = params[:promotion][:code]
    @promotion.discount_rate = params[:promotion][:discount_rate]
    @promotion.coupon_quantity = params[:promotion][:coupon_quantity]
    @promotion.expiration_date = params[:promotion][:expiration_date]

    @promotion.save

    redirect_to promotion_path(id: @promotion.id)
  end
end