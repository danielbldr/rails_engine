class ChangeInvoiceName < ActiveRecord::Migration[5.1]
  def change
    rename_column :invoices, :statuts, :status
  end
end
