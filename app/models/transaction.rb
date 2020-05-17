class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :card_expiration_date, presence: true
  validates :result, presence: true
  
  belongs_to :invoice
end
