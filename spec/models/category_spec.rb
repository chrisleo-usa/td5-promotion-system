require 'rails_helper'

describe Category do
  context 'validation' do
    it 'attributes cannot be blank' do
      category = Category.new

      expect(category.valid?).to eq(false)
      expect(category.errors.count).to eq(2)
    end

    it 'error messages are in portuguese' do
      category = Category.new

      category.valid?

      expect(category.errors[:name]).to include('não pode ficar em branco')
      expect(category.errors[:code]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      Category.create!(name: 'Tecnologia', code: 'TEC15')

      category = Category.new(code: 'TEC15')

      category.valid?

      expect(category.errors[:code]).to include('já está em uso')
    end
  end
end