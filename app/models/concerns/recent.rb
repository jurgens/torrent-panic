require 'active_support/concern'

module Recent
  extend ActiveSupport::Concern

  included do
    scope :recent, -> (n) { where("created_at >= ?", n.days.ago) }
  end
end
