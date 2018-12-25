MIN = 'a' * Console::NAME_RANGE.first # 3
MAX = 'a' * Console::NAME_RANGE.last # 20
MIN_DOWN = 'a' * (Console::NAME_RANGE.first - 1) # 2
MAX_UP = 'a' * (Console::NAME_RANGE.last + 1) # 21
NUMBER = ('1' * Game::DIGIT)
NUMBER_UP = ('1' * (Game::DIGIT + 1))

RSpec.describe Validation do
  let(:dummy_class) { Class.new { extend Validation } }
  context 'check, length of an user input is valid POSITIVE' do
    it 'when a value of an user input is in a range(min-boundary value)' do
      result = dummy_class.validate_length(MIN, Console::NAME_RANGE)
      expect(result).to eq(nil)
    end
    it 'check the max-boundary of value' do
      result = dummy_class.validate_length(MAX, Console::NAME_RANGE)
      expect(result).to eq(nil)
    end
  end
  context 'check, length of an user input is INvalid NEGATIVE' do
    it 'when a value of an user input is NOT in a range(min-boundary value)' do
      result = dummy_class.validate_length(MIN_DOWN, Console::NAME_RANGE)
      expect(result).to eq('Wrong length!')
    end
    it 'check the max-boundary of value' do
      result = dummy_class.validate_length(MAX_UP, Console::NAME_RANGE)
      expect(result).to eq('Wrong length!')
    end
  end
  context 'check, is user input string?' do
    it 'when an user input is string POSITIVE' do
      result = dummy_class.validate_string(MIN)
      expect(result).to eq(nil)
    end
    it 'when an user input is NOT string NEGATIVE' do
      result = dummy_class.validate_string(NUMBER)
      expect(result).to eq('Value is not string')
    end
  end
  context 'check, is user input number?' do
    it 'when an user input is number POSITIVE' do
      result = dummy_class.validate_number(NUMBER)
      expect(result).to eq(nil)
    end
    it 'when an user input is NOT number NEGATIVE' do
      result = dummy_class.validate_number(MIN)
      expect(result).to eq('Value is not number')
    end
  end

  context 'check an user input of name NAME' do
    it 'when an user input of name is valid POSITIVE' do
      result = dummy_class.errors_array_string(MIN, Console::NAME_RANGE)
      expect(result).to eq(true)
    end
    it 'when an user input of name is NOT valid NEGATIVE' do
      result = dummy_class.errors_array_string(MIN_DOWN, Console::NAME_RANGE)
      expect(result).to eq(false)
    end
  end
  #  context "check an user input of secret code" do
  #     before (:each) do
  #       NUMBER = ("1" * Game::DIGIT)
  #       NUMBER_UP = ("1" * (Game::DIGIT+1))
  #     end
  #
  #     it "when an user input of secret code is valid POSITIVE" do
  #     result=dummy_class.errors_array_guess(NUMBER, Game::DIGIT)
  #     expect(result).to eq(true)
  #     end
  #     it "when an user input of secret code is NOT valid NEGATIVE " do
  #     result=dummy_class.errors_array_guess(NUMBER_UP,Game::DIGIT)
  #     expect(result).to eq(false)
  #     end
  #   end
end
