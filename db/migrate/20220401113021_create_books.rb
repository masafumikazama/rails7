class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: false do |t|
      t.string :uuid, null: false, primary_key: true
      t.string :title, null: false, limit: 30
      t.string :auther
      t.string :publisher
      t.date :published_on
      t.string :series
      t.integer :page_size, null: false

      t.timestamps
    end
  end
end
