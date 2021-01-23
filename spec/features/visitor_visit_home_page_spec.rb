require 'rails_helper'

feature 'Visitor visit home page' do
  scenario 'successfully' do
    # AAA
    # ARRANGE
    
    # ACT - O que fazer? Visitar a página principal.
    visit root_path # Método visit(root_path) é do Capybara. 

    # ASSERT - Como fazer? 
    # expect().to e have_content são do Rspec
    expect(page).to have_content('Promotion System') 
    # Se espera que na page tenha um conteúdo. Qual? ('Promotion System) | Não interessa aonde ou de que jeito, só interessa que tenha este conteúdo na page.  
    expect(page).to have_content('Boas vindas ao sistema de gestão de '\
                                 'promoções') 
                                 # Se espera que na page tenha um conteúdo. Qual? (Boas Vindas...) | Também não interessa de que jeito, só apareça na tela. 
  end
end
