module Api
  module V1
    class Api::V1::CouponsController < ApiController
      #Api::V1::CouponsController é necessário definir a hierarquia das pastas, então Coupons controller está dentro da pasta V1, dentro da pasta Api. Ou com os módulos, que é como está no api_controller.rb
      def show
        coupon = Coupon.find_by(code: params[:id])
        return render status: 404, json: "{ msg: 'coupon not found' }" if coupon.nil?
        render json: coupon.as_json(only: [:code, :status],
                                    include: {
                                              promotion: { only: :discount_rate}
                                              }), status:200
      end
    end
  end
end

