
class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  has_one :promotion_approval # Com has_one é possível criar outra promotion_approval, mas o has_one sempre irá pegar a última. Podem ter 10, que ele sempre estará pegando a última promotion_approval.

  has_many :category_promotions, dependent: :destroy
  has_many :categories, through: :category_promotions, dependent: :destroy

  belongs_to :user 
  #o belongs_to é para associarmos a tabela promotion com a tabela users através da foreign key. Então uma promoção pertence a um usuário. Como o usuário tem que existir primeiro para depois criar a promoção, temos que fazer uma migration com "rails g migration add_user_ref_to_promotion user:references"

  validates :name, :discount_rate, :code, :expiration_date, :coupon_quantity, presence: true
  validates :code, uniqueness: true

  def generate_coupons!
    # Se quisermos atribuir um novo valor para code, precisamos utilizar self.code ou @code, para que Ruby entenda que quer ter essa atribuição. 
    # @code ou self.code = 'ABC'

    Coupon.transaction do
      # como já está em promotion, não é necessário mais @promotion, então passamos apenas coupon_quantity ou self.coupon_quantity
      (1..coupon_quantity).each do |number|
        coupons.create!(code: "#{code}-#{'%04d' % number}")
        # Transformar em um array de hashs e utilizar o insert_all
      end
    end
  end

  def approve!(approval_user)
    # criamos outra classe (PromotionApproval) que estará vinculado a uma promoção e ao usuário que está logado. 
    PromotionApproval.create(promotion: self, user: approval_user)
  end

  def approved?
    promotion_approval
    # Verifica se tem alguma promotion_approval, está buscando através do has_one promotion_approval.
  end

  def approver
    # approver nada mais é do que pegar o usuário no promotion_approval
    promotion_approval.user
  end
end

# Método de instância - roda em um objecto, por exemplo em cima de promotion
# @promotion.create
# @promotion.new