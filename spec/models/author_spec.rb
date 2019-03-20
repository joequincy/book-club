require 'rails_helper'

RSpec.describe Author, type: :model do

  describe 'relationships' do
    it { should have_many(:author_books) }
    it { should have_many(:books).through(:author_books) }
  end

  describe 'validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a name' do
        author = Author.create
        expect(author).to_not be_valid
      end
    end
  end

end
