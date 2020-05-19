require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'class methods' do
    it 'will return items based off of query param' do
      create_list(:merchant, 3)
      params = { "name" => Merchant.last.name[0..-4]}

      expect(Merchant.search(params).first).to eq(Merchant.last)
    end
  end
end
