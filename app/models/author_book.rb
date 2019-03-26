class AuthorBook < ApplicationRecord
  belongs_to :author
  belongs_to :book
  has_many :reviews, through: :book
end
