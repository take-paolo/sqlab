require 'rails_helper'

RSpec.describe Practice, type: :model do
  describe 'validation' do
    let!(:practice) { build(:practice, sample_database_uid: 1) }

    it 'is valid all with attributes' do
      expect(practice).to be_valid
      expect(practice.errors).to be_empty
    end

    it 'is invalid without chapter_id' do
      practice.chapter = nil

      expect(practice).to be_invalid
      expect(practice.errors[:chapter]).to include('を入力してください')
    end

    it 'is invalid without name' do
      practice.name = ''

      expect(practice).to be_invalid
      expect(practice.errors[:name]).to include('を入力してください')
    end

    it 'is invalid without question' do
      practice.question = ''

      expect(practice).to be_invalid
      expect(practice.errors[:question]).to include('を入力してください')
    end

    it 'is invalid without answer' do
      practice.answer = ''

      expect(practice).to be_invalid
      expect(practice.errors[:answer]).to include('を入力してください')
    end

    it 'is invalid without sample_database_uid' do
      practice.sample_database_uid = ''

      expect(practice).to be_invalid
      expect(practice.errors[:sample_database_uid]).to include('を入力してください')
    end

    it 'is invalid without display_er_diagram' do
      practice.display_er_diagram = nil

      expect(practice).to be_invalid
      expect(practice.errors[:display_er_diagram]).to include('は一覧にありません')
    end

    it 'is invalid without enabled' do
      practice.enabled = nil

      expect(practice).to be_invalid
      expect(practice.errors[:enabled]).to include('は一覧にありません')
    end

    it 'is invalid without published' do
      practice.published = nil

      expect(practice).to be_invalid
      expect(practice.errors[:published]).to include('は一覧にありません')
    end

    it 'is invalid without requires_auth' do
      practice.requires_auth = nil

      expect(practice).to be_invalid
      expect(practice.errors[:requires_auth]).to include('は一覧にありません')
    end
  end
end
