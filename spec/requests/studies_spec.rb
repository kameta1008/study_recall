require 'rails_helper'

RSpec.describe "Studies", type: :request do
  include Devise::Test::IntegrationHelpers 

  before do
    @user = FactoryBot.create(:user) 
    sign_in @user                    
    @study = FactoryBot.create(:study, user: @user) 
  end
  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get studies_path
      binding.pry
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの学習のテキストが存在する' do 
    end
  end
end
