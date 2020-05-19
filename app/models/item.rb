class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search(params)
    items = []
    params.each do |key, value|
      items += if %w[name description].include?(key)
                 Item.where("#{key} ILIKE ?", "%#{value}%")
               elsif %w[created_at updated_at].include?(key)
                 Item.where("#{key}": to_date(value))
               else Item.where("#{key} = ?", value)
               end
    end
    items.uniq
  end

  def self.to_date(date)
    date = Date.parse(date)
    date.midnight..date.end_of_day
  end
end
