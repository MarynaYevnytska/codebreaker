
class Console
  include Load
  include Validate
  include Storage_constants

  def initialize(send_to_console = 'greeting')
    print I18n.t(send_to_console)
  end

  def answer_for_user(answer)
    puts answer
  end

  def question
    print yield
    gets.chomp
  end

  def game_over(s_code, _game_statistics, game_status = 'failure')
    puts "Secret code is #{s_code.join}"
    case game_status
    when 'win' then puts I18n.t(MENU[:win])
    when 'failure' then puts I18n.t(MENU[:failure])
    end
    save?(_game_statistics)
    start?
    goodbye
  end

  def goodbye
    abort 'Goodbye'
  end

  def start
    Console_game.new(name, difficulty_choice).game_progress
  end

  def first_choice(input = 'start')
    while input != MENU[:no] || input != MENU[:yes]
      input = question { I18n.t(MENU[:continue?]) }
      case input
      when MENU[:no] then goodbye
      when MENU[:yes] then choice
      else
        puts I18n.t(MENU[:wrong_choice])
      end
    end
  end

  def choice(input = 'yes')
    while input != MENU[:exit]
      input = question { I18n.t(MENU[:choose_the_command]) }
      case input
      when MENU[:exit] then goodbye
      when MENU[:game_rules] then rules #binding.pry
      when MENU[:stats] then stats
      when MENU[:game_start] then start
      else

        puts I18n.t(MENU[:wrong_choice])
    end
    end
  end

  private

  def rules
    puts I18n.t(MENU[:game_rules])
    first_choice
  end

  def print_statistic
    load_statistics(FILE_NAME_ST).each_with_index do |value, index|
      puts I18n.t(MENU[:statistics], rating: index + 1, name: value[:user_name], difficulty: value[:difficulty],
                                     attempts_total: value[:attempts_total], attempts_used: value[:attempts_used],
                                     hints_total: value[:hints_total], hints_used: value[:hints_used])
    end
  end

  def stats
    print_statistic
    first_choice
  end

  def name_call
    puts I18n.t(MENU[:name])
    question { I18n.t(MENU[:user_answer]) }
  end

  def validate_name
    name = name_call
    if errors_array_string(name, NAME_RANGE)
      name
    else
      validate_name
    end
  end

  def difficulty_choice
    puts I18n.t(MENU[:describe_diff])
    @difficulty_value = question { I18n.t(MENU[:user_answer]) }
    until DIFF.key?(@difficulty_value.to_sym)
      puts I18n.t(MENU[:wrong_choice])
      @difficulty_value = question { I18n.t(MENU[:user_answer]) }
    end
    difficulty
  end

  def difficulty
    case @difficulty_value.capitalize
    when DIFF[:easy][:name] then DIFF[:easy]
    when DIFF[:medium][:name] then DIFF[:medium]
    when DIFF[:hell][:name] then DIFF[:hell]
    end
  end

  def name
    validate_name.capitalize
  end

  def save?(game_statistics)
    save(game_statistics, FILE_NAME_ST) if question { I18n.t(MENU[:save?]) } == MENU[:yes]
  end

  def start?
    case question { I18n.t(MENU[:restart?]) }
    when MENU[:yes] then choice
    when MENU[:no] then goodbye
    else
      puts I18n.t(MENU[:wrong_choice])
      start?
    end
  end
end
