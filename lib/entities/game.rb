NUM_RANGE = 6
DIGIT = 4
MESSAGE_GU = { "attempt": 'user_answer',
               "nil": 'nil',
               "win": 'win', "failure": 'failure' }.freeze
PLUS = '+'.freeze
MINUS = '-'.freeze

class Game
  attr_reader :difficulty, :secret_code
  attr_accessor :hint_clone_scode

  def initialize(difficulty)
    @difficulty = difficulty
    @secret_code = create_secret_code
    @hint_clone_scode = @secret_code.shuffle
  end

  def compare(user_input)
    case user_input.chars
    when @secret_code then MESSAGE_GU[:win]
    else
      plus_minus_factoring(user_input)
    end
  end

  def hint
    remainder = @hint_clone_scode.pop(@hint_clone_scode.length - 1)
    hint = @hint_clone_scode - remainder
    @hint_clone_scode = remainder
    hint[0].to_s
  end

  private

  def create_secret_code
    Array.new(DIGIT).map! { |_number| rand(NUM_RANGE).to_s }
  end

  def plus_factor(user_input)
    @answer_plus = []
    @remainder_plus_factor = Array.new(4, NUM_RANGE + 1)
    user_input.chars.each_with_index do |val_user, ind_user|
      @secret_code.each_with_index do |val_sec, ind_sec|
        if val_sec == val_user && ind_user == ind_sec
          @answer_plus.push(PLUS)
          @remainder_plus_factor[ind_user] = nil
        else
          @remainder_plus_factor[ind_user] = val_user
        end
      end
    end
 end

  def minus_factor
    @answer_minus = {}
    @remainder_plus_factor.each_with_index do |val_user, ind_user|
      @secret_code.each_with_index do |val_sec, ind_sec|
        @answer_minus[val_user] = MINUS if val_sec == val_user && ind_sec != ind_user
      end
    end
  end

  def plus_minus_factoring(user_input)
    plus_factor(user_input)
    minus_factor
    @answer_plus.push(@answer_minus.values).join
  end
end
