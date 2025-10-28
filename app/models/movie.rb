class Movie < ApplicationRecord
 validates :title, presence: true, length: { maximum: 150 }
  validates :director, presence: true, length: { maximum: 100 }
  validates :release_year, presence: true,
                           numericality: { only_integer: true, greater_than: 1870, less_than_or_equal_to: Date.current.year }
  validates :rating, presence: true, inclusion: { in: %w[G PG PG-13 R NC-17 Unknown], message: "%{value} is not a valid rating" }

  has_many :reviews, dependent: :destroy
end
