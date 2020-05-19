class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search(params)
    attribute = params.keys.first
    search_value = params.values.first
    if %w[name description].include?(attribute)
      Item.where("#{attribute} ILIKE ?", "%#{search_value}%")
    else
      Item.where("#{attribute} = ?", search_value)
    end
  end
end
