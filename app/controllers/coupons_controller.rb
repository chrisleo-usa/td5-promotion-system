class CouponsController < ApplicationController
  def disable
    @coupon = Coupon.find(params[:id])
    @coupon.inactive!
    redirect_to @coupon.promotion
    # retorna para o show da promoção
  end

  def enable
    @coupon = Coupon.find(params[:id])
    @coupon.active!
    redirect_to @coupon.promotion
  end
end