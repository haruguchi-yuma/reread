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

  it 'サマリーが51文字以上であれば無効な状態であること' do
    read_history = FactoryBot.build(:read_history, summary: 'a' * 50)
    read_history.valid?
    expect(read_history.errors[:summary]).not_to include('は50文字以内で入力してください')

    long_summary_read_history = FactoryBot.build(:read_history, summary: 'a' * 51)
    long_summary_read_history.valid?
    expect(long_summary_read_history.errors[:summary]).to include('は50文字以内で入力してください')
  end

  it 'メモが301文字以上であれば無効な状態であること' do
    read_history = FactoryBot.build(:read_history, description: 'a' * 300)
    read_history.valid?
    expect(read_history.errors[:description]).not_to include('は300文字以内で入力してください')

    long_description_read_history = FactoryBot.build(:read_history, description: 'a' * 301)
    long_description_read_history.valid?
    expect(long_description_read_history.errors[:description]).to include('は300文字以内で入力してください')
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
