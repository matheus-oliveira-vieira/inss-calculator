require 'rails_helper'

RSpec.describe 'Proponent edit page', type: :system do
  let!(:proponent) do
    create(:proponent,
      name: "João da Silva",
      cpf: "123.456.789-00",
      birth_date: Date.new(1990, 1, 1),
      email: "joao@example.com",
      salary: 3000.0,
      inss_discount: 300.0,
      address: build(:address, street: "Rua A", state: "SE"),
      contacts: [ build(:contact, contact_type: :mobile, value: "79999999999") ]
    )
  end

  before do
    driven_by(:rack_test)
    login_as(proponent, scope: :proponent)
    visit edit_api_v1_proponent_path(proponent)
  end

  it 'allows edit proponent and update fields' do
    fill_in 'Nome', with: 'João Atualizado'
    fill_in 'CPF', with: '321.654.987-00'
    fill_in 'E-mail', with: 'novo@email.com'
    fill_in 'Salário', with: 5000

    fill_in 'Rua', with: 'Rua Nova'
    fill_in 'Número', with: '123'
    fill_in 'Bairro', with: 'Centro'
    fill_in 'Cidade', with: 'Salvador'
    select 'Bahia', from: 'Estado'
    fill_in 'CEP', with: '49000-000'

    within all('.contact-fields').first do
      click_link 'Remover'
    end

    click_link 'Adicionar Contato'

    within all('.contact-fields').last do
      select 'Telefone Fixo', from: find('select[name*="[contact_type]"]')[:id]
      fill_in find('input[name*="[value]"]')[:id], with: '7922222222'
    end

    click_button 'Salvar'

    expect(page).to have_content('Proponente atualizado com sucesso')
    expect(page).to have_content('João Atualizado')
    expect(page).to have_content('321.654.987-00')
  end
end
