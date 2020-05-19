class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :items
  has_many :invoice_items, through: :items
  has_many :transactions

  validates :status, presence: true
end
