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

FactoryBot.define do
  factory :release do
    movie
    sequence(:title) { |n| "release#{n}" }
  end
end
