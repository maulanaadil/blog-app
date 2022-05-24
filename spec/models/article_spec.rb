require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end

    it 'belongs_to category' do
      association = described_class.reflect_on_association(:category).macro
      expect(association).to eq :belongs_to
    end
  end

  let(:article) { build(:article) }

  it 'creates succesfully' do 
    expect(article).to be_valid
  end

  it 'is not valid without a category' do 
    article.category_id = nil
    expect(article).not_to be_valid
  end

  it 'is not valid without a title' do 
    article.title = nil
    expect(article).not_to be_valid
  end

  it 'is not valid  without a user_id' do
    article.user_id = nil
    expect(article).not_to be_valid
  end

  it 'is not valid  with a title, shorter than 5 characters' do 
    article.title = 'a' * 4
    expect(article).not_to be_valid
  end

  it 'is not valid  with a title, longer than 255 characters' do 
    article.title = 'a' * 260
    expect(article).not_to be_valid
  end

  it 'is not valid without a content' do 
    article.content = nil
    expect(article).not_to be_valid
  end

  it 'is not valid  with a content, shorter than 20 characters' do 
    article.content = 'a' * 10
    expect(article).not_to be_valid
  end

  it 'is not valid  with a content, longer than 1000 characters' do 
    article.content = 'a' * 1050
    expect(article).not_to be_valid
  end
end
