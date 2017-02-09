require_relative 'errors'

class Safe
  DEFAULT_COMBINATION = '1234'
  VALID_COMBINATION = /\A\d{4}\z/

  attr_reader :remaining_attempts, :max_attempts

  def initialize(max_attempts = 3)
    @state = :unlocked
    @max_attempts = max_attempts
    @locked = false
    @relocked = false
  end

  def lock(combination = nil)
    raise IncorrectStateError, 'Already locked' if locked?
    combination ||= DEFAULT_COMBINATION

    validate_new_combination(combination.to_s)
    @combination = combination.to_s
    @locked = true
    @remaining_attempts = max_attempts
  end

  def locked?
    !!@locked
  end

  def relocked?
    remaining_attempts && remaining_attempts <= 0
  end

  def state
    return :relocked if relocked?
    return :locked if locked?
    :unlocked
  end

  def unlock(combination)
    raise IncorrectStateError, 'Already unlocked' unless locked?
    raise IncorrectStateError, 'Safe cannot be opened' if relocked?

    return open_safe if combination == @combination
    mark_failed_attempt
  end

  private

  def mark_failed_attempt
    @remaining_attempts -= 1
    false
  end

  def open_safe
    @combination = nil
    @locked = false
    true
  end

  def validate_new_combination(combination)
      raise ArgumentError, 'Combination must be 4 digits' unless combination =~ VALID_COMBINATION
  end
end
