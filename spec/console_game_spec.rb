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
end
