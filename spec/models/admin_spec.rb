# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  let :admin do
    build(:admin)
  end

  describe 'バリデーションについて' do
    subject do
      admin
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#email' do
      context '存在しない場合' do
        before :each do
          subject.email = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('メールアドレスを入力してください')
        end
      end

      context 'uniqueでない場合' do
        before :each do
          admin = create(:admin)
          subject.email = admin.email
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('メールアドレスはすでに存在します')
        end
      end

      %i[
        email0.com
        あああ.com
        今井.com
        @@.com
      ].each do |email|
        context '不正なemailの場合' do
          before :each do
            subject.email = email
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('メールアドレスは不正な値です')
          end
        end
      end
    end
  end
end
