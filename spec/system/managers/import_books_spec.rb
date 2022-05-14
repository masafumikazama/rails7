require 'spec_helper'

RSpec.describe CsvImportWorker do

  let!(:manager) { create(:manager) }
  let!(:book_csv) { create(:book_csv, manager: manager) }
  let!(:book_csv_params) { attributes_for(:book_csv) }

  let(:sqs_msg) { double message_id: 'fc754df7-9cc2-4c41-96ca-5996a44b771e',
                  body: { "book_csv_id": book_csv.id }.to_json,
                  delete: nil }

  describe 'perform メソッドのテスト' do
    subject { CsvImportWorker.new }

    it '標準出力を表示' do
      expect { subject.perform(sqs_msg, sqs_msg.body) }.to output(sqs_msg.body).to_stdout
    end

    it 'メッセージの削除' do
      expect(sqs_msg).to receive(:delete)

      subject.perform(sqs_msg, body)
    end

    it '新規メッセージの投入' do
      sqs_queue = double 'other queue'

      allow(Shoryuken::Client).to receive(:queues).
        with('other_queue').and_return(sqs_queue)

      expect(sqs_queue).to receive(:send_message).
        with('new test')

      subject.perform(sqs_msg, body)
    end
  end
end
