require 'rails_helper'

feature 'Admin update informations' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'attributes cannot be blank' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    Category.create!(name: 'Tecnologia', code: 'TEC15')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Tecnologia'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Salvar'

    expect(Category.count).to eq(1)
    expect(page).to have_content('Não foi possível alterar a categoria')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
  end

  scenario 'sucessfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    category = Category.create!(name: 'Tecnologia', code: 'TEC15')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Tecnologia'
    click_on 'Editar'
    fill_in 'Nome', with: 'Comida'
    fill_in 'Código', with: 'FOOD15'
    click_on 'Salvar'

    category.reload
    expect(page).not_to have_content('Tecnologia')
    expect(page).not_to have_content('TEC15')
    expect(page).to have_content('Comida')
    expect(page).to have_content('FOOD15')
  end
end