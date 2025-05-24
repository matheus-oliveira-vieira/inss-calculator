class Contact < ApplicationRecord
  belongs_to :proponent

  validates :value, presence: true

  enum :contact_type, { home_phone: 1, mobile: 2, whatsapp: 3, email: 4 }
end
