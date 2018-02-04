class Size
  include ActionView::Helpers::NumberHelper
  MEGABYTE = 1024 * 1024

  def self.parse(size)
    matcher = size.match /([\d\.]+)\s*(\w{2})/
    return 0 unless matcher.present?

    number = matcher[1].to_f
    measurement = matcher[2]

    case measurement
      when 'GB'
      then number * 1024
      when 'MB'
      then number
      when 'KB'
      then number / 1024
      else
        0
    end.round
  end

  def self.print(size)
    self.new.number_to_human_size(MEGABYTE * size.to_i)
  end
end
