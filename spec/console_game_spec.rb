DIFF = { "easy": { "name": 'Easy',
                   "difficulty": { "hints": 2, "attempts": 15 } },
         "medium": { "name": 'Medium',
                     "difficulty": { "hints": 1, "attempts": 10 } },
         "hell": { "name": 'Hell',
                   "difficulty": { "hints": 1, "attempts": 5 } } }.freeze
HINT = DIFF[:easy][:difficulty][:hints]
DIGIT = 4
NUMBER = '1' * DIGIT # 1111
ATTEMPTS = (1..15).freeze
ZERO = 0
WIN = 'win'.freeze
RSpec.describe Console_game do
  let!(:console_game) { described_class.new('Maryna', DIFF[:easy]) }
  let!(:name) { console_game.name }
  let!(:difficulty) { console_game.difficulty }
  let!(:messages) { console_game.messages }
  let!(:game) { console_game.game }
  let!(:console){Console.new}

  context 'when game start ' do

    it 'when the variable `name` is exist', positive: true do
      expect(name.class).to eq(String)
    end
    it 'when the variable `difficulty` is exist', positive: true do
      expect(difficulty.class).to eq(Hash)
    end
    it 'when the  difficulty contains `difficulty name` && `difficulty`', positive: true do
      expect(difficulty.size).to eq(2)
    end
    it 'when the  difficulty contains `attempts` && `hints`', positive: true do
      expect(difficulty[:difficulty].size).to eq(2)
    end
    it 'when the variable `messages` is exist', positive: true do
      expect(messages.class).to eq(Console)
    end
    it 'when the variable `game` is exist', positive: true do
      expect(game.class).to eq(Game)
    end
    it 'when the value of difficulty moved from console_game to game', positive: true do
      expect(difficulty == game.difficulty).to eq(true)
    end
  end
   it 'when user won and calls game_over with secret code, statistics and status' do
     allow_any_instance_of(Console).to receive(:question).and_return(NUMBER)
     allow_any_instance_of(Game).to receive(:compare).and_return('win')
     expect(messages).to receive(:game_over).with(kind_of(Array), {:attempts_total=>15, :attempts_used=>15,:difficulty=>"Easy", :hints_total=>2, :hints_used=>0, :user_name=>"Maryna"}, "win")
     console_game.game_progress
  end
it 'when computer won and game continue' do
    allow_any_instance_of(Console).to receive(:question).and_return(NUMBER)
    allow_any_instance_of(Game).to receive(:compare).and_return('++--')
    expect(messages).to receive(:answer_for_user).with(kind_of(String)).exactly(DIFF[:easy][:difficulty][:attempts]).times
    console_game.game_progress
end
it 'when user want to get hint and  hints are there' do
    allow_any_instance_of(Console).to receive(:question).and_return('hint')
    allow_any_instance_of(Game).to receive(:hint).and_return("1")
    expect(messages).to receive(:answer_for_user).with(kind_of(String))
    console_game.game_progress
end
it 'when user want to get hint but all the hints was used' do
  allow_any_instance_of(Console).to receive(:question).and_return('hint')
  console_game.instance_variable_set(:@current_hint, 0)
  expect(STDOUT).to receive(:puts).with(I18n.t(USER_ANSWER[:no_hints]))
  console_game.game_progress
end
it 'when user want to exit and press `exit`' do
  allow_any_instance_of(Console).to receive(:question).and_return('exit')
  expect(messages).to receive(:goodbye).exactly(DIFF[:easy][:difficulty][:attempts]+1).times
  console_game.game_progress
end
it 'when guess was used if user input is number ' do
  allow_any_instance_of(Console).to receive(:question).and_return(NUMBER)
  allow_any_instance_of(Game).to receive(:copare).and_return('++--')
  expect { game.compare(NUMBER) }.to change { console_game.current_attempt }.by(-1)
end
it 'when guess wasn`t used if user input is hint ' do
  allow_any_instance_of(Console).to receive(:question).and_return('hint')
  expect { game.compare }.to change { console_game.current_attempt }.by(0)
end
it 'when value of current attemt change if user input is hint ' do
  allow_any_instance_of(Console).to receive(:question).and_return('hint')
  expect { game.compare }.to change { console_game.current_hints }.by(-1)
end
end
