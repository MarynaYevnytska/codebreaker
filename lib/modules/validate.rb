module Validation
  def validate_emptiness(object)
    'Value is empty' if object.to_s.empty?
  end

  def validate_class(object, klass)
    'Wrong class!' unless object.is_a? klass
  end

  def validate_string(object)
    check = begin
                Integer(object)
            rescue StandardError
              false
              end
    'Value is not string' if check
  end

  def validate_number(object)
    check = begin
                Integer(object)
            rescue StandardError
              false
              end
    'Value is not number' unless check
  end

  def validate_length(object, range)
    'Wrong length!' unless range.cover?(object.length)
  end

  def errors_array_string(object, range)
    errors = []
    errors << validate_length(object, range)
    errors << validate_string(object)
    puts errors.compact
    errors.compact.empty?
  end

  def errors_array_guess(object, range)
    errors = []
    errors << validate_length(object, range)
    errors << validate_number(object)
    puts errors.compact
    errors.compact.empty?
  end
end
