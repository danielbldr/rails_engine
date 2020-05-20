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
                     Merchant.where("#{key}": to_date(value).midnight..
                                              to_date(value).end_of_day)
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

  def self.most_items_sold(limit)
    Merchant.joins(:invoice_items, :transactions)
            .where(transactions: { result: 'success' })
            .select('merchants.*, SUM(invoice_items.quantity) AS item_count')
            .group(:id)
            .order('item_count DESC')
            .limit(limit)
  end

  def self.all_merchant_revenue(dates)
    Merchant.joins(:invoice_items, :transactions)
            .where(transactions: { result: 'success' },
                   invoices: { created_at: to_date(dates['start'])...
                               to_date(dates['end']).end_of_day })
            .select('sum(invoice_items.quantity * invoice_items.unit_price)
                     AS revenue')
            .order('revenue DESC')
  end

  def self.to_date(date)
    Date.parse(date)
  end
end
