class SafePresenter < SimpleDelegator
  def initialize(safe)
    super(safe)
  end

  # include any presentation methods you need here
end
