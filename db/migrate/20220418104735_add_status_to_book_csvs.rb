class AddStatusToBookCsvs < ActiveRecord::Migration[7.0]
  def change
    add_column :book_csvs, :status, :string
  end
end
