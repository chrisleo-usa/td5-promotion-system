require 'rails_helper'

feature 'Admin view categories' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path). to eq(new_user_session_path)
  end

  scenario 'and no category are created' do
    user = User.create!(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'succesfully' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    Category.create!(name: 'Tecnologia', code: 'TEC15')
    Category.create!(name: 'Pizza', code: 'PIZZA30')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('Pizza')
  end

  scenario 'and view details' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    category = Category.create!(name: 'Tecnologia', code: 'TEC15')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on category.name

    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('TEC15')
  end

  scenario 'and return to categories page' do
    user = User.create!(email: 'joao@email.com', password: '123456')
    Category.create!(name: 'Tecnologia', code: 'TEC15')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Tecnologia'
    click_on 'Voltar'

    expect(current_path).to eq(categories_path)
  end

  scenario 'and return to home page' do
    user = User.create!(email: 'joao@email.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

end