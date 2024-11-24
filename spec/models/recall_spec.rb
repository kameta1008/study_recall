require 'rails_helper'

RSpec.describe Recall, type: :model do
  before do
    @study = FactoryBot.create(:study) 
    @recall = FactoryBot.create(:recall, study: @study, recall_date: Date.today, interval: 1)
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

  describe '復習完了時の動作' do
    context '次の復習予定日が生成される場合' do
      it 'intervalが1の場合、次は2日後に予定が生成される' do
        @recall.update(completed: true) # 復習完了
        next_recall = @study.recalls.last
        expect(next_recall.recall_date).to eq(@recall.recall_date + 2.days)
        expect(next_recall.interval).to eq(2) # 次の間隔が2（3日後）であること
      end

      it 'intervalが2の場合、次は4日後に予定が生成される' do
        @recall.update(interval: 2, completed: true) # intervalを2に変更して復習完了
        next_recall = @study.recalls.last
        expect(next_recall.recall_date).to eq(@recall.recall_date + 4.days)
        expect(next_recall.interval).to eq(4) # 次の間隔が4（7日後）であること
      end

      it 'intervalが4の場合、次は23日後に予定が生成される' do
        @recall.update(interval: 4, completed: true) # intervalを4に変更して復習完了
        next_recall = @study.recalls.last
        expect(next_recall.recall_date).to eq(@recall.recall_date + 23.days)
        expect(next_recall.interval).to eq(23) # 次の間隔が23（30日後）であること
      end
    end

    context '次の復習予定日が生成されない場合' do
      it 'intervalが23の場合、新しい予定日は生成されない' do
        @recall.update(interval: 23, completed: true) # 最後の間隔を設定
        expect(@study.recalls.count).to eq(1) # 新しい予定が生成されていないこと
      end
    end
  end
end