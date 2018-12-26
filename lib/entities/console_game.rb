# frozen_string_literal: true

MESSAGE_FOR_USER = { "start_game": 'guess', "failure": 'failure' }.freeze
USER_ANSWER = { "attempt": 'user_answer', "no_hints": 'no_hints' }.freeze

class Console_game
  include Validation

  attr_reader :name, :difficulty
  attr_accessor :messages, :game, :current_hint, :current_attempt, :game_status
  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
    @messages = Console.new(MESSAGE_FOR_USER[:start_game])
    @game = Game.new(difficulty)
  end

  def user_input
    @messages.question { I18n.t(USER_ANSWER[:attempt]) }
  end

  def user_game_move
    input_handle(user_input, @current_hint)
  end

  def guess
    @game_status = @game.compare(user_game_move)
    @current_hint = @game.current_hint
  end

  def game_progress
    @current_hint = @difficulty[:difficulty][:hints].to_i
    @current_attempt = 1
    range = 1..@difficulty[:difficulty][:attempts].to_i
    while range.cover?(@current_attempt)
      guess
      break if @game_status == 'win'

      @messages.answer_for_user(@game_status)
      @current_attempt += 1
    end
    @messages.game_over(@game.secret_code, statistics)
  end

  def statistics
    attempts_used = @difficulty[:difficulty][:attempts] - @current_attempt
    hints_used = @difficulty[:difficulty][:hints] - @current_hint
    { "user_name": @name, "game_status": @game_status,
      "difficulty": @difficulty[:name],
      "attempts_total": @attempts_total,
      "attempts_used": attempts_used,
      "hints_total": @hints_total,
      "hints_used": hints_used }
  end

  def input_validate?(input)
    user_input until errors_array_guess(user_input, (DIGIT..DIGIT))
    input
  end

  def input_handle(user_input, current_hint)
    case user_input
    when 'hint' then check_hint(current_hint)
    when 'exit' then @messages.goodbye
    else
      input_validate?(user_input)
      end
    end

  def check_hint(current_hint)
    puts I18n.t(USER_ANSWER[:no_hints]) if current_hint.zero?
    view_hint(current_hint) unless current_hint.zero?
  end

  def view_hint(current_hint)
    current_hint -= 1
    @current_hint = current_hint
    @messages.answer_for_user(@game.get_hint)
    user_game_move
  end
end
