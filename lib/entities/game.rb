NUM_RANGE = 6
DIGIT = 4
MESSAGE_GU = { "attempt": 'user_answer',
               "nil": 'nil',
               "win": 'win', "failure": 'failure' }.freeze
PLUS = '+'
MINUS = '-'

class Game
  attr_reader :difficulty, :secret_code
  attr_accessor :hints_total, :hint_clone_scode, :current_hint

  def initialize(difficulty)
    @difficulty = difficulty
    @hints_total = difficulty[:difficulty][:hints].to_i
    @secret_code = create_secret_code
    @hint_clone_scode = @secret_code.shuffle
  end

  def compare(user_input)
    MESSAGE_GU[:win] if user_input.chars == @secret_code
    plus_minus_factoring(user_input) unless user_input.chars == @secret_code
  end

  def view_hint(current_hint)
    @current_hint = current_hint
    remainder = @hint_clone_scode.pop(@hint_clone_scode.length - 1)
    hint = (@hint_clone_scode - remainder)
    @current_hint -= 1
    @hint_clone_scode = remainder
    hint[0].to_s
  end

  private

  def create_secret_code
    secret_code = Array.new(DIGIT).map! { |_number| rand(NUM_RANGE).to_s }
  end

  def plus_minus_factoring(user_input)
    answer_plus = []
    answer_minus = {}
    user_input.chars.each_with_index do |val_user, ind_user|
      @secret_code.each_with_index do |val_sec, ind_sec|
        answer_plus.push(PLUS) if val_sec == val_user && ind_user == ind_sec
        answer_minus[val_user] = MINUS if val_sec == val_user && ind_user != ind_sec
      end
    end
    answer_plus.push(answer_minus.values).join
  end
end
