class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant

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
