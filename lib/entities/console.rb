FILE_NAME_ST = '../stat.yml'.freeze
NAME_RANGE = (3..20).freeze
DIFF = { "easy": { "name": 'Easy',
                   "difficulty": { "hints": 2, "attempts": 15 } },
         "medium": { "name": 'Medium',
                     "difficulty": { "hints": 1, "attempts": 10 } },
         "hell": { "name": 'Hell',
                   "difficulty": { "hints": 1, "attempts": 5 } } }.freeze

MENU = { "choose_the_command": 'choose_the_command',
         "yes": 'y', "no": 'n',
         "game_rules": 'rules',
         "stats": 'stats', "game_start": 'start',
         "goodbye": 'goodbye', "exit": 'exit',
         "describe_diff": 'difficult', "user_answer": 'user_answer',
         "wrong_choice": 'wrong_choice', "name": 'name',
         "win": 'win', "failure": 'failure',
         "restart?": 'restart?', "save?": 'save?',
         "statistics": 'statistics', "game_attemt": 'game_attemt',
         "game_hint": 'game_hint' }.freeze

class Console
  include Load
  include Validate

  def initialize(send_to_console = 'greeting')
    print I18n.t(send_to_console)
  end

  def answer_for_user(answer)
    puts "Secret code has #{answer}"
  end

  def choice(user_choice)
    case user_choice
    when MENU[:no] then goodbye
    when MENU[:yes] then choose_the_command
    when MENU[:game_rules] then rules
    when MENU[:stats] then stats
    when MENU[:game_start] then start
    when MENU[:exit] then goodbye
    else
      puts I18n.t(MENU[:wrong_choice])
      choose_the_command
    end
  end

  def choose_the_command
    puts I18n.t(MENU[:choose_the_command])
    choice(question { I18n.t(MENU[:user_answer]) })
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
    puts I18n.t(MENU[:goodbye])
    exit
  end

  def start
    Console_game.new(name, difficulty).game_progress
  end

  private

  def exit
    puts 'exit'.chomp
  end

  def rules
    puts I18n.t(MENU[:game_rules])
    choice(question {})
  end

  def print_statistic
    list = load_statistics(FILE_NAME_ST)
    list.each_with_index do |value, index|
      puts I18n.t(MENU[:statistics], rating: index + 1, name: value[:user_name], difficulty: value[:difficulty],
                                     attempts_total: value[:attempts_total], attempts_used: value[:attempts_used],
                                     hints_total: value[:hints_total], hints_used: value[:hints_used])
    end
  end

  def stats
    print_statistic
    choice(question {})
  end

  def name_call
    puts I18n.t(MENU[:name])
    question { I18n.t(MENU[:user_answer]) }
  end

  def validate_name?(name)
    name = name_call until errors_array_string(name, NAME_RANGE)
    name
  end

  def choose_the_difficulty
    puts I18n.t(MENU[:describe_diff])
    question { I18n.t(MENU[:user_answer]) }
  end

  def difficulty_registration(user_choice)
    case user_choice.capitalize
    when DIFF[:easy][:name]     then    DIFF[:easy]
    when DIFF[:medium][:name]   then    DIFF[:medium]
    when DIFF[:hell][:name]     then    DIFF[:hell]
    else
      puts I18n.t(MENU[:wrong_choice])
      choose_the_difficulty
    end
  end

  def name
    validate_name?(name_call).capitalize
  end

  def difficulty
    difficulty_registration(choose_the_difficulty)
  end

  def save?(_game_statistics)
    save(_game_statistics, FILE_NAME_ST) if question { I18n.t(MENU[:save?]) } == MENU[:yes]
  end

  def start?
    choose_the_command if question { I18n.t(MENU[:restart?]) } == MENU[:yes]
  end
end
