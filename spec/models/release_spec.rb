require 'rails_helper'

RSpec.describe Release, type: :model do
  it { should belong_to :movie }
end
