class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices

  def self.search(params)
    merchants = []
    params.each do |key, value|
      merchants += if %w[created_at updated_at].include?(key)
                     date = Date.parse(value)
                     Merchant.where("#{key}": date.midnight..date.end_of_day)
                   else
                     Merchant.where("#{key} ILIKE ?", "%#{value}%")
                   end
    end
    merchants.uniq
  end

  def self.highest_earning_merchants(limit)
    Merchant.joins(:invoice_items, :transactions)
            .where(transactions: { result: 'success' })
            .select('merchants.*,
                     SUM(invoice_items.quantity * invoice_items.unit_price)
                     AS rev')
            .group(:id)
            .order('rev DESC')
            .limit(limit)
  end
end
