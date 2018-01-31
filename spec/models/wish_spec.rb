# == Schema Information
#
# Table name: wishes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  movie_id    :integer
#  notified_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Wish, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
