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

    expect(current_path).to eq(categories_path)
    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('TEC15')
  end
  # scenario 'from index page' do
  #   visit root_path
  #   click_on 'Categorias'

  #   expect(page).to have_link('Cadastrar uma categoria', 
  #                             href: new_category_path)
  # end

  # scenario 'succesfully' do 
  #   visit root_path
  #   click_on 'Categorias'
  #   click_on 'Cadastrar uma categoria'

  #   fill_in 'Categoria', with: 'Tecnologia'
  #   click_on 'Criar categoria'

  #   expect(current_path).to eq(category_path) #Verificar sobre essa rota. 
  #   expect(page).to have_content('Tecnologia')
  #   expect(page).to have_link('Voltar')
  # end
end