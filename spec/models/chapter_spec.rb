require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe 'validation' do
    let!(:chapter) { build(:chapter) }

    it 'is valid all with attributes' do
      expect(chapter).to be_valid
      expect(chapter.errors).to be_empty
    end

    it 'is invalid without work_id' do
      chapter.work = nil
      expect(chapter).to be_invalid
      expect(chapter.errors[:work]).to include('を入力してください')
    end

    it 'is invalid without name' do
      chapter.name = ''
      expect(chapter).to be_invalid
      expect(chapter.errors[:name]).to include('を入力してください')
    end
  end
end
