require 'rails_helper'

RSpec.describe 'New Proponent', type: :system do
  let(:proponent) { create(:proponent) }
  before do
    driven_by(:rack_test)
     login_as(proponent, scope: :proponent)
    visit new_api_v1_proponent_path
  end

  it 'allows to create a new proponent with all data filled' do
    fill_in 'Nome', with: 'Carlos Souza'
    fill_in 'CPF', with: '123.456.789-10'
    fill_in 'Data de nascimento', with: '1990-01-01'
    fill_in 'E-mail', with: 'carlos@example.com'
    fill_in 'Salário', with: '4000.00'

    fill_in 'Rua', with: 'Rua A'
    fill_in 'Número', with: '101'
    fill_in 'Bairro', with: 'Centro'
    fill_in 'Cidade', with: 'Aracaju'
    select 'Sergipe', from: 'Estado'
    fill_in 'CEP', with: '49000-000'

    select 'Telefone Fixo', from: find('select[name*="contact_type"]')[:id]
    fill_in find('input[name*="value"]')[:id], with: '79999999999'
    click_link 'Adicionar Contato'
    select 'Telefone Fixo', from: find('select[name*="contact_type"]')[:id]
    fill_in find('input[name*="value"]')[:id], with: '79999999999'

    click_button 'Salvar'

    expect(page).to have_content('Proponente criado com sucesso')
    expect(page).to have_content('Carlos Souza')
    expect(page).to have_content('123.456.789-10')
  end
end
