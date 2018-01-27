class Rutracker

  def initialize

  end

  def detect(title)
    rows = table_scan

    rows.select do |row|
      detect_title(row, title)
    end

    rows.any?
  end

  private

  def table_scan
    search_results_page
  end

  def detect_title(row, title)

  end

  def search_results_page
    binding.pry
    File.open(Rails.root)
  end
end
