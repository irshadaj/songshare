class SearchResults < SimpleDelegator
  attr_reader :current_page, :limit_value, :total_count

  def initialize(results, limit:, page: nil, total: nil)
    super(results)
    @current_page = page || 1
    @limit_value = limit
    @total_count = total || results.try(:count)
  end

  def offset_value
    (current_page - 1) * limit_value
  end

  def total_pages
    (total_count.to_f / limit_value).ceil
  end
end
