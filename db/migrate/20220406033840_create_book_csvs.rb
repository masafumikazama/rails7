class CreateBookCsvs < ActiveRecord::Migration[7.0]
  def change
    create_table :book_csvs do |t|
      t.datetime :imported_at

      t.timestamps
    end
  end
end
