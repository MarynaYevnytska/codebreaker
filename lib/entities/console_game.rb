# frozen_string_literal: true

MESSAGE_FOR_USER = { "start_game": 'guess', "failure": 'failure' }.freeze
USER_ANSWER = { "attempt": 'user_answer', "no_hints": 'no_hints' }.freeze

class Console_game
  include Validation

  attr_reader :name, :difficulty

  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
    @messages = Console.new(MESSAGE_FOR_USER[:start_game])
    @game = Game.new(difficulty)
  end

  def game_progress
    @current_hint = @difficulty[:difficulty][:hints].to_i
    @current_attempt = 1
    while (0..@difficulty[:difficulty][:attempts].to_i).cover?(@current_attempt)
      consol_response = @messages.question { I18n.t(USER_ANSWER[:attempt]) }
      valid_consol_response = input_handle(consol_response, @current_hint)
      @game_status = @game.compare(valid_consol_response)
      @current_hint = @game.current_hint
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

  def console_input
    input_handle(@messages.question { I18n.t(USER_ANSWER[:attempt]) },
                 @current_hint)
  end

  def input_validate?(console_response)
    until errors_array_guess(console_response, (DIGIT..DIGIT))
      console_response = @messages.question { I18n.t(USER_ANSWER[:attempt]) }
     end
    console_response
  end

  def input_handle(console_response, _current_hint)
    case console_response
    when 'hint' then check_hint(@current_hint)
    when 'exit' then @messages.goodbye
    else
      input_validate?(console_response)
      end
    end

  def check_hint(current_hint)
    puts I18n.t(USER_ANSWER[:no_hints]) if @current_hint.zero?
    unless @current_hint.zero?
      puts "you has #{current_hint} hint"
      @current_hint -= 1
      @messages.answer_for_user(@game.view_hint)
      console_input
  end
end
end
