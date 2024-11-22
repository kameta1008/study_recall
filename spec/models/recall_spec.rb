require 'rails_helper'

RSpec.describe Recall, type: :model do
  before do
    @study = FactoryBot.create(:study) 
    @recall = FactoryBot.build(:recall, study: @study) 
  end

  describe '復習予定日の保存' do
    context '保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@recall).to be_valid
      end
    end

    context '保存できない場合' do
      it 'recall_dateが空では保存できない' do
        @recall.recall_date = nil
        @recall.valid?
        expect(@recall.errors.full_messages).to include("Recall date can't be blank")
      end

      it 'intervalが空では保存できない' do
        @recall.interval = nil
        @recall.valid?
        expect(@recall.errors.full_messages).to include("Interval can't be blank")
      end

      it 'studyが紐づいていなければ保存できない' do
        @recall.study = nil
        @recall.valid?
        expect(@recall.errors.full_messages).to include("Study must exist")
      end
    end
  end

  describe '復習予定日の生成' do
    context '新しい復習予定日を生成する場合' do
      it '復習完了時に次の予定日が正しく生成される' do
        @recall.update(completed: true)
        next_recall = @study.recalls.last
        expect(next_recall.recall_date).to eq(@recall.recall_date + 3.days) 
        expect(next_recall.interval).to eq(2) 
      end
    end

    context '次の復習予定がない場合' do
      it '最後の復習を完了した場合、新しい予定日は生成されない' do
        @recall.interval = 3
        @recall.completed = true
        @recall.save
        expect(@study.recalls.count).to eq(1) 
      end
    end
  end
end