class Address < ApplicationRecord
  belongs_to :proponent

  validates :zip_code, presence: true, format: { with: /\A\d{5}-?\d{3}\z/, message: "deve estar no formato 12345678 ou 12345-678" }

   STATES = [
    [ "Acre", "AC" ],
    [ "Alagoas", "AL" ],
    [ "Amapá", "AP" ],
    [ "Amazonas", "AM" ],
    [ "Bahia", "BA" ],
    [ "Ceará", "CE" ],
    [ "Distrito Federal", "DF" ],
    [ "Espírito Santo", "ES" ],
    [ "Goiás", "GO" ],
    [ "Maranhão", "MA" ],
    [ "Mato Grosso", "MT" ],
    [ "Mato Grosso do Sul", "MS" ],
    [ "Minas Gerais", "MG" ],
    [ "Pará", "PA" ],
    [ "Paraíba", "PB" ],
    [ "Paraná", "PR" ],
    [ "Pernambuco", "PE" ],
    [ "Piauí", "PI" ],
    [ "Rio de Janeiro", "RJ" ],
    [ "Rio Grande do Norte", "RN" ],
    [ "Rio Grande do Sul", "RS" ],
    [ "Rondônia", "RO" ],
    [ "Roraima", "RR" ],
    [ "Santa Catarina", "SC" ],
    [ "São Paulo", "SP" ],
    [ "Sergipe", "SE" ],
    [ "Tocantins", "TO" ]
  ].freeze
end
