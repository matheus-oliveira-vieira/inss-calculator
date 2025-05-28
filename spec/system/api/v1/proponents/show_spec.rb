require 'rails_helper'

RSpec.describe 'Proponent show page', type: :system do
  let(:proponent) do
    create(:proponent,
           name: "Joana Silva",
           cpf: "987.654.321-00",
           salary: 3000.50,
           inss_discount: 330.00)
  end

  before do
    driven_by(:rack_test)
    create(:address,
           proponent: proponent,
           street: "Rua das Flores",
           number: "123",
           neighborhood: "Centro",
           city: "Aracaju",
           state: "SE",
           zip_code: "49000-000")

    create(:contact, proponent: proponent, contact_type: :home_phone, value: "(79) 99999-0000")
    create(:contact, proponent: proponent, contact_type: :mobile, value: "(79) 91234-1234")


    login_as(proponent, scope: :proponent)
    visit api_v1_proponent_path(proponent)
  end

  it 'displays proponent main data' do
    expect(page).to have_content("Detalhes do Proponente")
    expect(page).to have_content("Joana Silva")
    expect(page).to have_content("987.654.321-00")
    expect(page).to have_content("R$ 3.000,50")
    expect(page).to have_content("R$ 330,00")
  end

  it 'display address data' do
    expect(page).to have_content("Rua das Flores, 123")
    expect(page).to have_content("Centro")
    expect(page).to have_content("Aracaju/SE")
    expect(page).to have_content("49000-000")
  end

  it 'display contacts' do
    expect(page).to have_content("Telefone Fixo:")
    expect(page).to have_content("(79) 99999-0000")
    expect(page).to have_content("Celular:")
    expect(page).to have_content("(79) 91234-1234")
  end

  it 'display navigation buttons' do
    expect(page).to have_link("Editar")
    expect(page).to have_link("Voltar")
  end
end
