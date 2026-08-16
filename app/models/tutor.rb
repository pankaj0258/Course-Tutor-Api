class Tutor < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false }
  validates :experience_years, presence: true,
            numericality: { greater_than_or_equal_to: 0 }
end
