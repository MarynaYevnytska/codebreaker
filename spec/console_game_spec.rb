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

  context 'when game params is correct  at the start game', positive: true do
    before do
      allow(console_game).to receive(:game_progress).and_return(NUMBER)
    end

    it 'when the content of current attempt is correct  at the start game' do
      expect(console_game.current_attempt).to eq(1)
    end
    it 'when the content of current hints is correct  at the start game' do
      expect(console_game.current_hint).to eq(DIFF[:easy][:difficulty][:hints])
    end
    it 'when the content of game status is correct  at the start game' do
      expect(console_game.game_status).to be_instance_of(String)
    end
  end

  context 'when the user use attempt for getting  `hint`' do
    it 'when the user  get answer `hint` from console', positive: true do
      dbl1 = double
      dbl2 = double
      dbl3 = double
      allow(console_game).to receive(:guess_result).and_return(NUMBER)
      expect(messages).to receive(:game_over).with(dbl1, dbl2, dbl3)
    end
    it 'when the user `number` was handled and returned a result', positive: true do
      game_status_result = console_game.game_status
      expect(game_status_result).to be_instance_of(String)
    end
    it 'when the user `number` was handled and the game status is win', positive: true do
      allow(game).to receive(:compare).with(NUMBER).and_return(WIN)
      expect(console_game.messages).to receive(:game_over).once
      console_game.messages.game_over('secret_code', 'statistics', 'game_status')
    end
  end
end
