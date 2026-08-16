class Course < ApplicationRecord
  has_many :tutors, dependent: :destroy

  enum :status, { active: 0, inactive: 1 }, validate: true

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :status, presence: true
end