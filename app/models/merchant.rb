class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices

  def self.search(params)
    attribute = params.keys.first
    search_value = params.values.first
    if %w[created_at updated_at].include?(attribute)
      date = Date.parse(search_value)
      Merchant.where("#{attribute}": date.midnight..date.end_of_day)
    else
      Merchant.where("#{attribute} ILIKE ?", "%#{search_value}%")
    end
  end
end
