require 'rails_helper'

feature 'Admin registers a product category' do
  scenario 'from index page' do
    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Cadastrar categoria', href: new_category_path)
  end

  scenario 'succesfully' do
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

  scenario 'and view details' do
    category = Category.create!(name: 'Tecnologia', code: 'TEC15')

    visit root_path
    click_on 'Categorias'
    click_on category.name

    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('TEC15')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to categories page' do
    category = Category.create!(name: 'Tecnologia', code: 'TEC15')

    visit root_path
    click_on 'Categorias'
    click_on category.name
    click_on 'Voltar'

    expect(current_path).to eq(categories_path)
  end

end