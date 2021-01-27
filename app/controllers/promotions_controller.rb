class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
    # Se não for expor a variável promotions para a view, então não usamos o @. Como queremos expor ela para a views, então é necessário o @promotions

  end

  def show
    id = params[:id]
    @promotion = Promotion.find(id)
  end
end