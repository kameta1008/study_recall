require 'rails_helper'

RSpec.describe Study, type: :model do
  before do
    @study = FactoryBot.build(:study)
  end

  describe '学習記録の投稿' do
    context '投稿ができる場合' do
      it '画像、タイトル、テキストがすべて入力されていれば投稿できる' do
        expect(@study).to be_valid
      end

      it '画像がなくても投稿できる' do
        @study.image = nil
        expect(@study).to be_valid
      end
    end

    context '投稿ができない場合' do
      it 'テキストが空では投稿できない' do
        @study.content = ''
        @study.valid?
        expect(@study.errors.full_messages).to include("Content can't be blank")
      end

      it 'タイトルが空では投稿できない' do
        @study.title = ''
        @study.valid?
        expect(@study.errors.full_messages).to include("Title can't be blank")
      end

      it 'ユーザーが紐づいていなければ投稿できない' do
        @study.user = nil
        @study.valid?
        expect(@study.errors.full_messages).to include("User must exist")
      end
    end
  end
end
