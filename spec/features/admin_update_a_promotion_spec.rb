require 'rails_helper'

feature 'Admin update promotions informations' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'attributes cannot be blank' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Salvar'

    expect(Promotion.count).to eq(1)
    expect(page).to have_content('Não foi possível alterar a promoção')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Desconto não pode ficar em branco')
    expect(page).to have_content('Quantidade de cupons não pode ficar em branco')
    expect(page).to have_content('Data de término não pode ficar em branco')
  end

  scenario 'successfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Editar'
    fill_in 'Nome', with: 'TreinaDev'
    fill_in 'Descrição', with: 'Black Friday TreinaDev'
    fill_in 'Código', with: 'TD50'
    fill_in 'Desconto', with: '30'
    fill_in 'Quantidade de cupons', with: '50'
    fill_in 'Data de término', with: '20/01/2025'
    click_on 'Salvar'

    promotion.reload
    expect(page).to have_content('TreinaDev')
    expect(page).to have_content('Black Friday TreinaDev')
    expect(page).to have_content('TD50')
    expect(page).to have_content('30')
    expect(page).to have_content('50')
    expect(page).to have_content('20/01/2025')
  end
end