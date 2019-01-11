# frozen_string_literal: true

MESSAGE_GU = { "attempt": 'user_answer',
               "nil": 'nil',
               "win": '++++', "failure": 'failure' }.freeze
MESSAGE_FOR_USER = { "start_game": 'guess', "failure": 'failure' }.freeze
USER_ANSWER = { "attempt": 'user_answer', "no_hints": 'no_hints' }.freeze
ZERO = 0
class Console_game
  include Validate

  attr_reader :name, :difficulty
  attr_accessor :messages, :game, :current_hint, :current_attempt, :game_status
  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
    @messages = Console.new(MESSAGE_FOR_USER[:start_game])
    @game = Game.new(difficulty)
  end

  def game_progress
    @current_hint = @difficulty[:difficulty][:hints].to_i
    @current_attempt = 1
    range = 1..@difficulty[:difficulty][:attempts].to_i
    while range.cover?(@current_attempt)
        #binding.pry
        @game_status = guess_result
      break if @game_status == MESSAGE_GU[:win]

      @messages.answer_for_user(@game_status)
      @current_attempt += 1
    end
    @messages.game_over(@game.secret_code, statistics, @game_status)
  end



  private
  
  def user_game_move
    input_handle(user_input, @current_hint)
  end

  def statistics
    attempts_used = @current_attempt - 1
    hints_used = @difficulty[:difficulty][:hints] - @current_hint
    { "user_name": @name,
      "difficulty": @difficulty[:name],
      "attempts_total": @difficulty[:difficulty][:attempts],
      "attempts_used": attempts_used,
      "hints_total": @difficulty[:difficulty][:hints],
      "hints_used": hints_used }
  end

  def guess_result
    @game.compare(user_game_move)
  end



  def user_input
    @messages.question { I18n.t(USER_ANSWER[:attempt]) }
  end

  def input_validate?(input)
    input = user_input until errors_array_guess(input, (DIGIT..DIGIT))
    input
  end

  def input_handle(console_response, current_hint)
    case console_response
    when 'hint' then check_hint(current_hint)
    when 'exit' then @messages.goodbye
    else
      input_validate?(console_response)
    end
  end

  def check_hint(current_hint)
    case current_hint
    when ZERO
      puts I18n.t(USER_ANSWER[:no_hints])
      input_handle(user_input, current_hint)
    when 1..@difficulty[:difficulty][:hints].to_i
      view_hint(current_hint)
    end
  end

  def view_hint(current_hint)
    current_hint -= 1
    @current_hint = current_hint
    @messages.answer_for_user(@game.hint)
    user_game_move
  end
end
