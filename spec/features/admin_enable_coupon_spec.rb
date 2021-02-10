require 'rails_helper'

feature 'Admin enables disabled coupons' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'succesfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                  expiration_date: '22/12/2033', user: user)

    coupon = Coupon.create!(code: 'ABC0001', promotion: promotion, status: :inactive)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Habilitar'

    coupon.reload
    expect(page).to have_content('ABC0001 - Habilitado')
    expect(coupon).to be_active
  end
end