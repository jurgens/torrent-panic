class Movie < ApplicationRecord
  has_many :releases
  has_many :wishes
end
