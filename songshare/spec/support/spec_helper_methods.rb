module SpecHelperMethods
  ALPHANUMERIC = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten

  def load_fixture(filename)
    File.open(Rails.root.join('spec', 'fixtures', filename), 'r', &:read)
  end

  def random_alphanumeric(num_chars = 1)
    [*1..num_chars].map { ALPHANUMERIC.sample }.join
  end
  module_function :random_alphanumeric
end
