require 'rails_helper' # rubocop:disable Layout/EndOfLine

RSpec.describe Meet, type: :model do
  it { should have_many(:meetings).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
