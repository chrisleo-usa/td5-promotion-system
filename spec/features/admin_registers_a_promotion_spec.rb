require 'rails_helper'

feature 'Admin registers a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'

    expect(current_path). to eq(new_user_session_path)
  end

  scenario 'from index page' do
    user = User.create!(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end

  scenario 'successfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Nome', with: 'Cyber Monday' #fill_in é o metodo padrão do capybara para preencher um input
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    click_on 'Criar'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
    expect(page).to have_content('Cadastrada por: joao@email.com')
    expect(page).to have_link('Voltar')
  end

  scenario 'and choose product categories' do
    Category.create!(name: 'Smartphones', code: 'CELL')
    Category.create!(name: 'Jogos', code: 'GAMES')
    Category.create!(name: 'Monitores', code: 'DISPLAYS')
    Category.create!(name: 'Webcams', code: 'WEBCANS')
    user = User.create!(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Nome', with: 'Cyber Monday' #fill_in é o metodo padrão do capybara para preencher um input
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    check 'Smartphones'
    check 'Jogos'
    check 'Monitores'
    click_on 'Criar'

    promotion = Promotion.last
    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Smartphones')
    expect(page).to have_content('Jogos')
    expect(page).to have_content('Monitores')
    expect(page).not_to have_content('Webcams')
  end
end
