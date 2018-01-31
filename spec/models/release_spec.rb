# == Schema Information
#
# Table name: releases
#
#  id       :integer          not null, primary key
#  movie_id :integer
#  title    :string
#  status   :string
#  link     :string
#  magnet   :string
#  seeds    :integer
#

require 'rails_helper'

RSpec.describe Release, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
