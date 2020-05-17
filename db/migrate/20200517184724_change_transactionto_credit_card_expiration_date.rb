class ChangeTransactiontoCreditCardExpirationDate < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :card_expiration_date, :credit_card_expiration_date
  end
end
