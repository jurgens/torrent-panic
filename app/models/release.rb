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

class Release < ApplicationRecord
  belongs_to :movie
end
