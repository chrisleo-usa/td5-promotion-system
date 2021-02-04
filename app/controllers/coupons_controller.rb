class CouponsController < ApplicationController
  def disable
    @coupon = Coupon.find(params[:id])
    @coupon.inactive!
    redirect_to @coupon.promotion
    # retorna para o show da promoção
  end
end