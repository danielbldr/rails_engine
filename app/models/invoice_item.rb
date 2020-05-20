class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoices

  validates :quantity, presence: true
  validates :unit_price, presence: true

  def self.total_revenue(start_date, end_date)
    InvoiceItem.joins(invoice: :transactions)
               .where('date(invoices.created_at) BETWEEN ? AND ?',
                      start_date, end_date)
               .where("transactions.result = 'success'")
               .sum('unit_price * quantity')
  end
end
