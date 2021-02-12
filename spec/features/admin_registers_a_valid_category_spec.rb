require 'rails_helper'

feature 'Admin registers a valid category' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path). to eq(new_user_session_path)
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path 
    click_on 'Categorias'
    click_on 'Cadastrar categoria'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Criar'

    expect(Category.count).to eq 0
    expect(page).to have_content('Não foi possível criar a categoria')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
  end

  scenario 'and code must be unique' do 
    user = User.create!(email: 'joao@email.com', password: '123456')

    Category.create!(name: 'Tecnologia', code: 'TEC15')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria'
    fill_in 'Código', with: 'TEC15'
    click_on 'Criar'

    expect(page).to have_content('Código já está em uso')
  end

end