class Review < ApplicationRecord
  belongs_to :book
  validates :title, presence: true
  validates :description, presence: true
  validates :user, presence: true
  validates :rating, presence: true, numericality: { greater_than: 0, less_than: 6 }
end
