MIN = 'a' * Console::NAME_RANGE.first # 3a
MAX = 'a' * Console::NAME_RANGE.last # 20a
MIN_DOWN = 'a' * (Console::NAME_RANGE.first - 1) # 19a
MAX_UP = 'a' * (Console::NAME_RANGE.last + 1) # 21a
NUMBER = ('1' * Game::DIGIT)
NUMBER_UP = ('1' * (Game::DIGIT + 1))

RSpec.describe Validation do
  let(:dummy_class) { Class.new { extend Validation } }
  context 'check, length of an user input is valid', positive: true do
    it 'when a value of an user input is in a range(min-boundary value)' do
      result = dummy_class.length_valid?(MIN, Console::NAME_RANGE)
      expect(result).to eq(nil)
    end
    it 'check the max-boundary of value', positive: true do
      result = dummy_class.length_valid?(MAX, Console::NAME_RANGE)
      expect(result).to eq(nil)
    end
  end
  context 'check, length of an user input is INvalid', negative: true do
    it 'when a value of an user input is NOT in a range(min-boundary value)' do
      result = dummy_class.length_valid?(MIN_DOWN, Console::NAME_RANGE)
      expect(result).to eq('Wrong length!')
    end
    it 'check the max-boundary of value', negative: true do
      result = dummy_class.length_valid?(MAX_UP, Console::NAME_RANGE)
      expect(result).to eq('Wrong length!')
    end
  end
  context 'check, is user input string?' do
    it 'when an user input is string', positive: true do
      result = dummy_class.string?(MIN)
      expect(result).to eq(nil)
    end
    it 'when an user input is NOT string', negative: true do
      result = dummy_class.string?(NUMBER.to_i)
      expect(result).to eq('Value is not string')
    end
  end
  context 'check, is user input number?' do
    it 'when an user input is number', positive: true do
      result = dummy_class.number?(Integer(NUMBER))
      expect(result).to eq(nil)
    end
    it 'when an user input is NOT number', negative: true do
      result = dummy_class.number?(NUMBER_UP)
      expect(result).to be('Value is not number')
    end
  end

  context 'check an user input of name' do
    it 'when an user input of name is valid', positive: true do
      result = dummy_class.errors_array_string(MIN, Console::NAME_RANGE)
      expect(result).to eq(true)
    end
    it 'when an user input of name is NOT valid', negative: true do
      result = dummy_class.errors_array_string(MIN_DOWN, Console::NAME_RANGE)
      expect(result).to eq(false)
    end
  end
  context 'check an user input of number' do
    it 'when an user input of number is valid', positive: true do
      result = dummy_class.errors_array_guess(NUMBER, Game::DIGIT..Game::DIGIT)
      expect(result).to eq(true)
    end
    it 'when an user input of name is NOT valid', negative: true do
      result = dummy_class.errors_array_guess(NUMBER_UP, Game::DIGIT..Game::DIGIT)
      expect(result).to eq(false)
    end
  end
end
