require 'rails_helper'

RSpec.describe 'Proponents index page', type: :system do
  let(:proponent) { create(:proponent) }

  context 'when proponent is logged' do
    before do
      driven_by(:rack_test)
      login_as(proponent, scope: :proponent)
      create(:proponent, name: "João", cpf: "123.456.789-00", inss_discount: 1_000.00)
      visit api_v1_proponents_path
    end

    it 'shows proponent data' do
      expect(page).to have_content("Proponentes")
      expect(page).to have_content("João")
      expect(page).to have_content("123.456.789-00")
      expect(page).to have_content("R$ 1.000,00")
      expect(page).to have_button("Logoff")
      expect(page).to have_link("Novo Proponente")
      expect(page).to have_content("Faixas Salariais - Listagem")
      expect(page).to have_content("Faixas Salariais - Gráfico")
    end
  end

  context 'when proponent is not logged' do
    it 'shows login message' do
      visit api_v1_proponents_path
      expect(page).to have_content("Faça login para continuar")
      expect(page).to have_button("Login")
    end
  end
end
