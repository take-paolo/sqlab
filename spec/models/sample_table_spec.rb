require 'rails_helper'

RSpec.describe SampleTable, type: :model do
  describe 'validation' do
    let!(:practice) { create(:practice, sample_database_uid: 1) }
    let!(:sample_table) { build(:sample_table, practice: practice, uid: 1) }

    it 'is valid all with attributes' do
      expect(sample_table).to be_valid
      expect(sample_table.errors).to be_empty
    end

    it 'is invalid without uid' do
      sample_table.uid = ''

      expect(sample_table).to be_invalid
      expect(sample_table.errors[:uid]).to include('を入力してください')
    end

    it 'is invalid with duplicate uid and practice_id combination' do
      sample_table = create(:sample_table, practice: practice, uid: 1)
      sample_table_with_duplicate_uid = build(:sample_table, practice: practice, uid: sample_table.uid)

      expect(sample_table_with_duplicate_uid).to be_invalid
      expect(sample_table_with_duplicate_uid.errors[:uid]).to include('はすでに存在します')
    end
  end
end
