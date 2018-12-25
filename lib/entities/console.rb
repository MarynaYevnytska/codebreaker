FILE_NAME_ST = '../stat.yml'.freeze
NAME_RANGE = (3..20).freeze
LEVEL_DIF = 3
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
         "restart?": 'restart?', "save?": 'save?' }.freeze

class Console
  include Storage
  include Validation

  def initialize(send_to_console = 'greeting')
    print I18n.t(send_to_console)
  end

  def question
    print yield
    gets.chomp
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
      puts I18n.t(MENU[:wrong_choice]).colorize(:red)
      choose_the_command
    end
  end

  def choose_the_command
    puts I18n.t(MENU[:choose_the_command]).colorize(:light_yellow)
    choice(question { I18n.t(MENU[:user_answer]) })
  end

  def goodbye
    puts I18n.t(MENU[:goodbye]).colorize(:light_yellow)
    exit
  end

  def exit
    puts 'exit'.chomp
  end

  def rules
    puts I18n.t(MENU[:game_rules]).colorize(:light_cyan)
    choice(question {})
  end

  def stats
    puts load_settings(FILE_NAME_ST)
    choice(question {})
  end

  def name_call
    puts I18n.t(MENU[:name]).colorize(:light_cyan)
    question { I18n.t(MENU[:user_answer]) }
  end

  def validate_name?(name)
    name = name_call until errors_array_string(name, NAME_RANGE)
    name
  end

  def choose_the_difficulty
    puts I18n.t(MENU[:describe_diff]).colorize(:light_cyan)
    question { I18n.t(MENU[:user_answer]) }
  end

  def difficulty_registration(user_choice)
    case user_choice.capitalize
    when DIFF[:easy][:name]     then    DIFF[:easy]
    when DIFF[:medium][:name]   then    DIFF[:medium]
    when DIFF[:hell][:name]     then    DIFF[:hell]
    else
      puts I18n.t(MENU[:wrong_choice]).colorize(:red)
      choose_the_difficulty
    end
  end

  def name
    validate_name?(name_call).capitalize
  end

  def difficulty
    difficulty_registration(choose_the_difficulty)
  end

  def start
    Console_game.new(name, difficulty).game_progress
  end

  def game_over(s_code, game_statistics, game_status = 'failure')
    puts "Secret code is #{s_code.join}".colorize(:yellow)
    puts I18n.t(MENU[:win]).colorize(:red) if game_status == 'win'
    puts I18n.t(MENU[:failure]).colorize(:grey) if game_status == 'failure'
    save(game_statistics, FILE_NAME_ST) if question { I18n.t(MENU[:save?]) } == MENU[:yes]
    start if question { I18n.t(MENU[:restart?]) } == MENU[:yes]
    goodbye
  end
end
