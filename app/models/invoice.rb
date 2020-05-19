class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, dependent: :destroy

  validates :status, presence: true
end
