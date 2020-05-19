class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

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
end
