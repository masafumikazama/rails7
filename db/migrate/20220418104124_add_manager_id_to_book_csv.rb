class AddManagerIdToBookCsv < ActiveRecord::Migration[7.0]
  def change
    add_reference :book_csvs, :manager, null: false, foreign_key: true
  end
end
