class Review < ApplicationRecord
  belongs_to :movie

  validates :reviewer, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true, length: { minimum: 10 }
end