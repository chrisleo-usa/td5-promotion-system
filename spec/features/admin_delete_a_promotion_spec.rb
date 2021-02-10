require 'rails_helper'

feature 'Admin delete a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'sucesssfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    promotion = Promotion.create!(name: 'TreinaDev', description: 'Black Fryday TreinaDev',
                                  code: 'TD50', discount_rate: 50, coupon_quantity: 80,
                                  expiration_date: '01/01/2030', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Deletar'

    expect(current_path).to eq(promotions_path)
    expect(page).not_to have_content(promotion.name)
  end
end