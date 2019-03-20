require 'rails_helper'

RSpec.describe Book, type: :model do

  describe 'relationships' do
    it { should have_many(:authors).through(:author_books) }
    it { should have_many(:reviews) }

  end


end
