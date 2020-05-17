require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
task import: :environment do
  Rake::Task['db:schema:load'].invoke

  files = Dir['db/data/*'].sort
  files.each do |file|
    db_conn = ActiveRecord::Base.connection.raw_connection
    resource = File.basename(file, '.*').sub(/\W+|\d+/, '')
    copy_statement = "COPY #{resource} FROM STDIN"

    enco = PG::TextEncoder::CopyRow.new
    db_conn.copy_data copy_statement, enco do
      CSV.foreach(file, headers: true) do |row|
        db_conn.put_copy_data(row.fields)
      end
    end
  end
  Item.update_all('unit_price = unit_price/100.0')
  InvoiceItem.update_all('unit_price = unit_price/100.0')
end
