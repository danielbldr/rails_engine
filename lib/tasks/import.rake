require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
task import: :environment do
  Rake::Task['db:schema:load'].invoke

  files = ["customers.csv", "merchants.csv", "items.csv", "invoices.csv", "invoice_items.csv", "transactions.csv"]
  files.each do |file|
    db_conn = ActiveRecord::Base.connection.raw_connection
    copy_statement = "COPY #{file.split('.').first} FROM STDIN"
    file_path = "db/data/#{file}"

    enco = PG::TextEncoder::CopyRow.new
    db_conn.copy_data copy_statement, enco do
      CSV.foreach(file_path, headers: true) do |row|
        db_conn.put_copy_data(row.fields)
      end
    end
  end
end
