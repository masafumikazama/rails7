require 'rails_helper'

RSpec.describe 'CSVファイルインポートの画面遷移', type: :system do

  before(:each) do
    login_manager
  end

  file = CSV.generate do |csv|
    csv << ["name", "facebook_url"]
    csv << ["artict1", "nil"]
    csv << ["artict2", "facebook_url"]
  end

  context 'CSVファイルインポートの画面遷移' do
    it 'CSVファイルをインポートできることを確認' do
      visit new_managers_import_book_path


    end
  end
end
