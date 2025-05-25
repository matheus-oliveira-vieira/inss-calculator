class Proponent < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :contacts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true

  validates :cpf, presence: true
end
