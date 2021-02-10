require 'rails_helper'

feature 'admin disable coupon' do 
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                  expiration_date: '22/12/2033', user: user)

    coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Desabilitar'

    coupon.reload
    expect(page).to have_content('ABC0001 - Desabilitado')
    expect(coupon).to be_inactive
  end

  scenario 'does not view button' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                                  expiration_date: '22/12/2033', user: user)
    inactive_coupon = Coupon.create!(code: 'ABC0001', promotion: promotion, status: :inactive)

    active_coupon = Coupon.create!(code: 'ABC0002', promotion: promotion, status: :active)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name

    expect(page).to have_content('ABC0001 - Desabilitado')
    expect(page).to have_content('ABC0002 - Habilitado')
    # Sempre que se tem within, a variável page é equivalente ao conteúdo do bloco da string. Como é uma div, tudo que estiver dentro dessa div, então será testado. 
    within("div#coupon-#{active_coupon.id}") do
      expect(page).to have_link 'Desabilitar'
    end

    within("div#coupon-#{inactive_coupon.id}") do
      expect(page).not_to have_link 'Desabilitar'
    end
    # TODO: Pesquisar sobre testes de request com rspec, para quando o status do coupon for desativado e além do botão ser escondido com o IF na view, não seja possível enviar uma solicitação http. 
  end
end