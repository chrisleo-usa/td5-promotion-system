require 'rails_helper'

feature 'Admin view categories' do

  scenario 'and no category are created' do
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'succesfully' do
    Category.create!(name: 'Tecnologia', code: 'TEC15')
    Category.create!(name: 'Pizza', code: 'PIZZA30')

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('Pizza')
  end

  scenario 'and view details' do
    category = Category.create!(name: 'Tecnologia', code: 'TEC15')

    visit root_path
    click_on 'Categorias'
    click_on category.name

    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('TEC15')
  end

  scenario 'and return to categories page' do
    Category.create!(name: 'Tecnologia', code: 'TEC15')

    visit root_path
    click_on 'Categorias'
    click_on 'Tecnologia'
    click_on 'Voltar'

    expect(current_path).to eq(categories_path)
  end

  scenario 'and return to home page' do
    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

end