# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadHistory, type: :model do
  it '有効なファクトリがあること' do
    expect(FactoryBot.build(:read_history)).to be_valid
  end

  it 'サマリーがなければ無効な状態であること' do
    read_history = FactoryBot.build(:read_history, summary: nil)
    read_history.valid?
    expect(read_history.errors[:summary]).to include('を入力してください')
  end

  it '書籍がなければ無効な状態であること' do
    read_history = FactoryBot.build(:read_history, book: nil)
    read_history.valid?
    expect(read_history.errors[:book]).to include('を入力してください')
  end

  it '読み返す日が設定されていなければ無効な状態であること' do
    read_history = FactoryBot.build(:read_history, read_back_on: nil)
    read_history.valid?
    expect(read_history.errors[:read_back_on]).to include('を入力してください')
  end

  it '読み返す日を今日よりも過去の日付に設定した場合無効な状態であること' do
    read_history = FactoryBot.build(:read_history, read_back_on: Time.zone.yesterday)
    read_history.valid?
    expect(read_history.errors[:read_back_on]).to include('は今日より未来の日付を設定してください')
  end
end
