require "rails_helper"

RSpec.describe Course, type: :model do
  subject(:course) { build(:course) }

  describe "associations" do
    it { is_expected.to have_many(:tutors).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }

    it do
      is_expected.to validate_uniqueness_of(:name).case_insensitive
    end
  end

  describe "status enum" do
    it do
      expect(described_class.statuses).to eq(
        "active" => 0,
        "inactive" => 1
      )
    end
  end
end