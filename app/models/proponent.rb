class Proponent < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :contacts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true

  validates :cpf, presence: true
  before_validation :set_dummy_password_for_non_admin, on: :create

  private

  def set_dummy_password_for_non_admin
    unless admin?
      self.password = SecureRandom.hex(12)
      self.password_confirmation = self.password
    end
  end

  def password_required?
    admin? && super
  end
end
