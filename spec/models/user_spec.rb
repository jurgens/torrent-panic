# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  first_name     :string
#  last_name      :string
#  last_update_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  telegram_id    :integer
#  status         :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
