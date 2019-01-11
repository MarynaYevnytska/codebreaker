FILE_NAME_ST = './stat.yml'.freeze
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
         "game_hint": 'game_hint', "continue?": 'continue?' }.freeze

class Console
  include Load
  include Validate

  def initialize(send_to_console = 'greeting')
    print I18n.t(send_to_console)
  end

  def answer_for_user(answer)
    puts "Secret code has #{answer}"
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
    puts 'Exit'.chomp
  end

  def start
    Console_game.new(name, difficulty).game_progress
  end



  def choice
    puts I18n.t(MENU[:continue?])
    loop do
      case question {}
      when MENU[:yes] then
        puts I18n.t(MENU[:choose_the_command])
        next
      when MENU[:no]
        goodbye
        break
      when MENU[:exit]
        goodbye
        break
      when MENU[:game_rules] then return rules
      when MENU[:stats] then return stats
      when MENU[:game_start] then start
      else
        puts I18n.t(MENU[:wrong_choice])
      end
    end
  end

private

  def rules
    puts I18n.t(MENU[:game_rules])
    choice
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
    choice
  end

  def name_call
    puts I18n.t(MENU[:name])
    question { I18n.t(MENU[:user_answer]) }
  end

  def validate_name
    loop do
      name = name_call
      if errors_array_string(name, NAME_RANGE)
        return name
        break
      end
    end
  end

  def difficulty
    puts I18n.t(MENU[:describe_diff])
    loop do
      case question { I18n.t(MENU[:user_answer]) }.capitalize
      when DIFF[:easy][:name]

        return DIFF[:easy]
        break

      when DIFF[:medium][:name]

        return DIFF[:medium]
        break

      when DIFF[:hell][:name]

        return DIFF[:hell]
        break
      else
        puts I18n.t(MENU[:wrong_choice])
      end
    end
  end

  def name
    validate_name.capitalize
  end

  def save?(_game_statistics)
    save(_game_statistics, FILE_NAME_ST) if question { I18n.t(MENU[:save?]) } == MENU[:yes]
  end

  def start?
    loop do
      case question { I18n.t(MENU[:restart?]) }
      when MENU[:yes]
        choice
        break
      when MENU[:no]
        goodbye
        break
      end
    end
  end
end
