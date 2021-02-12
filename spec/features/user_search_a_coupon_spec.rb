require 'rails_helper'

feature 'user search for a coupon' do
  scenario 'successfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                  expiration_date: '22/12/2033', user: user)

    coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)

    login_as user, scope: :user
    visit root_path
    fill_in 'Busca'
    #TODO: FInalizar buscar cupom!
  end
end