require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'validation' do
    let!(:work) { build(:work) }

    it 'is valid all with attributes' do
      expect(work).to be_valid
      expect(work.errors).to be_empty
    end

    it 'is invalid without name' do
      work.name = ''

      expect(work).to be_invalid
      expect(work.errors[:name]).to include('を入力してください')
    end

    it 'is invalid without slug' do
      work.slug = ''

      expect(work).to be_invalid
      expect(work.errors[:slug]).to include('を入力してください')
    end

    it 'is invalid with wrong slug format(uppercase)' do
      work.slug = 'Slug'

      expect(work).to be_invalid
      expect(work.errors[:slug]).to include('は半角英字、アンダースコアのみが使えます')
    end

    it 'is invalid with wrong slug format(hyphen)' do
      work.slug = 'slug-slug'

      expect(work).to be_invalid
      expect(work.errors[:slug]).to include('は半角英字、アンダースコアのみが使えます')
    end

    it 'is invalid with wrong slug format(number)' do
      work.slug = 'slug1'

      expect(work).to be_invalid
      expect(work.errors[:slug]).to include('は半角英字、アンダースコアのみが使えます')
    end

    it 'is invalid with duplicate slug' do
      work = create(:work)
      work_with_duplicate_slug = build(:work, slug: work.slug)

      expect(work_with_duplicate_slug).to be_invalid
      expect(work_with_duplicate_slug.errors[:slug]).to include('はすでに存在します')
    end

    it 'is invalid without description' do
      work.description = ''

      expect(work).to be_invalid
      expect(work.errors[:description]).to include('を入力してください')
    end

    it 'is invalid without enabled' do
      work.enabled = nil

      expect(work).to be_invalid
      expect(work.errors[:enabled]).to include('は一覧にありません')
    end

    it 'is invalid without published' do
      work.published = nil

      expect(work).to be_invalid
      expect(work.errors[:published]).to include('は一覧にありません')
    end
  end
end
