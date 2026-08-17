require "rails_helper"

RSpec.describe Tutor, type: :model do
  subject(:tutor) { build(:tutor) }

  describe "associations" do
    it { is_expected.to belong_to(:course) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:experience_years) }

    it do
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    end

    it do
      is_expected.to validate_numericality_of(:experience_years)
        .is_greater_than_or_equal_to(0)
    end

    it "does not allow negative experience years" do
      tutor = build(:tutor, experience_years: -1)

      expect(tutor).not_to be_valid
      expect(tutor.errors[:experience_years]).to include(
        "must be greater than or equal to 0"
      )
    end
  end
end
