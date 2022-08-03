require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let!(:user) { build(:user) }

    it 'is valid all with attributes' do
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'is invalid without name' do
      user.name = ''

      expect(user).to be_invalid
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'is invalid with name longer than maximum characters' do
      user.name = 'a' * 33

      expect(user).to be_invalid
      expect(user.errors[:name]).to include('は32文字以内で入力してください')
    end

    it 'is invalid without email' do
      user.email = ''

      expect(user).to be_invalid
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'is invalid with duplicate email' do
      user = create(:user)
      user_with_duplicate_email = build(:user, email: user.email)

      expect(user_with_duplicate_email).to be_invalid
      expect(user_with_duplicate_email.errors[:email]).to include('はすでに存在します')
    end

    it 'is invalid without role' do
      user.role = nil

      expect(user).to be_invalid
      expect(user.errors[:role]).to include('を入力してください')
    end

    it 'is invalid without password' do
      user.password = ''

      expect(user).to be_invalid
      expect(user.errors[:password]).to include('は8文字以上で入力してください')
    end

    it 'is invalid with password shorter than minimum characters' do
      user.password = 'test'

      expect(user).to be_invalid
      expect(user.errors[:password]).to include('は8文字以上で入力してください')
    end

    it 'is invalid without password_confirmation' do
      user.password_confirmation = ''

      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include('を入力してください')
    end
  end
end
