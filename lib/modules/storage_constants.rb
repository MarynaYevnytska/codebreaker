
module Storage_constants

MESSAGE_GU = { "attempt": 'user_answer',
               "nil": 'nil',
               "win": '++++', "failure": 'failure' }.freeze
MESSAGE_FOR_USER = { "start_game": 'guess', "failure": 'failure' }.freeze
USER_ANSWER = { "attempt": 'user_answer', "no_hints": 'no_hints', "hint_is": 'hint_is' }.freeze
ZERO = 0
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
 NUM_RANGE = 6.freeze
 DIGIT = 4.freeze
 PLUS = '+'.freeze
 MINUS = '-'.freeze
 HINT = DIFF[:easy][:difficulty][:hints]
 NUMBER = '1' * DIGIT # 1111
 ATTEMPTS = (1..15).freeze
 WIN = 'win'.freeze
 MIN = 'a' * NAME_RANGE.first # 3.times(a)
 MAX = 'a' * NAME_RANGE.last # 20.times(a)
 MIN_DOWN = 'a' * (NAME_RANGE.first - 1) # 19.times(a)
 MAX_UP = 'a' * (NAME_RANGE.last + 1) # 21.times(a)
 NUMBER_UP = ('1' * (DIGIT + 1)) # 5.times(1)
end
