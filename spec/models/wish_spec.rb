require 'rails_helper'

RSpec.describe Wish, type: :model do
  it { should belong_to :user }
  it { should belong_to :movie }
end
