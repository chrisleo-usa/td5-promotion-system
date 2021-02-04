require 'rails_helper'

feature 'Admin registers a category' do
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
end