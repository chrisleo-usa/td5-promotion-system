require 'rails_helper'

feature 'Admin registers a category' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path). to eq(new_user_session_path)
  end

  scenario 'from index page' do
    user = User.create(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Cadastrar categoria', href: new_category_path)
  end

  scenario 'succesfully' do
    user = User.create(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria'

    fill_in 'Nome', with: 'Tecnologia'
    fill_in 'Código', with: 'TEC15'
    click_on 'Criar categoria'

    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('TEC15')
  end
end