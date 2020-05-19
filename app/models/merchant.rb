class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy

  def self.search(params)
    attribute = params.keys.first
    search_value = params.values.first
    Merchant.where("#{attribute} ILIKE ?", "%#{search_value}%")
  end
end
