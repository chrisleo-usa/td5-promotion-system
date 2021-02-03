require 'rails_helper'

feature 'Admin registers a valid category' do
  scenario 'and attributes cannot be blank' do
    visit root_path 
    click_on 'Categorias'
    click_on 'Cadastrar categoria'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    click_on 'Criar categoria'

    expect(Category.count).to eq 0
    expect(page).to have_content('Não foi possível criar a categoria')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
  end

  scenario 'and code must be unique' do 
    Category.create!(name: 'Tecnologia', code: 'TEC15')

    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria'
    fill_in 'Código', with: 'TEC15'
    click_on 'Criar categoria'

    expect(page).to have_content('Código já está em uso')
  end

end