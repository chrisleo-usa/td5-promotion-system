require 'rails_helper'

feature 'Admin search a promotion' do
  scenario 'succesfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    Promotion.create!(name: 'Casa do Marceneiro', description: 'Queima de estoque',
                      code: 'CDM80', discount_rate: 80, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)
    Promotion.create!(name: 'TreinaDev', description: 'Black Friday TreinaDev',
                      code: 'TD50', discount_rate: 50, coupon_quantity: 50,
                      expiration_date: '10/07/2021', user: user)
    Promotion.create!(name: 'Casa de Cristal', description: 'Liquida loja',
                      code: 'CC35', discount_rate: 30, coupon_quantity: 20,
                      expiration_date: '12/05/2021', user: user)

    login_as user, scope: :user
    visit root_path
    fill_in 'Busca', with: 'Casa'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_path)
    expect(page).to have_content('Casa do Marceneiro')
    expect(page).to have_content('Queima de estoque')
    expect(page).to have_content('Casa de Cristal')
    expect(page).to have_content('Liquida loja')
    expect(page).not_to have_content('TreinaDev')
    expect(page).not_to have_content('Black Friday TreinaDev')
  end

  scenario 'promotion not found' do
    visit root_path
    fill_in 'Busca', with: 'TreinaDev'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_path)
    expect(page).to have_content('Promoção não encontrada')
  end

  scenario 'and return to home page' do
    visit search_path
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end