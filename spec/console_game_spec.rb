HINT = Console::DIFF[:easy][:difficulty][:hints]
NUMBER = '1' * Game::DIGIT # 1111
ATTEMPTS = (1..Console::DIFF[:easy][:difficulty][:attempts]).freeze
ZERO = 0
WIN = 'win'.freeze
RSpec.describe Console_game do
  let(:console_game) { described_class.new('Sergey', Console::DIFF[:easy]) }
  let(:name) { console_game.name }
  let(:difficulty) { console_game.difficulty }
  let(:messages) { console_game.messages }
  let(:game) { console_game.game }

  context 'when game start ' do
    it 'when the variable `name` is exist', positive: true do
      expect(name.class).to eq(String)
    end
    it 'when the variable `difficulty` is exist', positive: true do
      expect(difficulty.class).to eq(Hash)
    end
    it 'when the  difficulty contains `name` && `difficulty`', positive: true do
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
      allow(console_game).to receive(:game_progress)
    end

    it 'when the content of current attempt is correct  at the start game' do
      expect(console_game.current_attempt == 1).to eq(true) # :TODO instance variable don't get
    end
    it 'when the content of current hints is correct  at the start game' do
      expect(console_game.current_hint).to eq(Console::DIFF[:medium][:difficulty][:hint])
    end
    it 'when the content of game status is correct  at the start game' do
      expect(console_game.game_status).to eq(nil)
    end
  end

  context 'when the user use attempt for getting  `hint`' do
    it 'when the user use attempt for getting  `hint`', positive: true do
      allow(console_game).to receive(:input_handle).with('hint', HINT).and_call_original
      expect(console_game).to receive(:check_hint).once
      console_game.check_hint
    end
    it 'when the user use attempt for getting  `hint` && hitn is zero', positive: true do
      allow(console_game).to receive(:check_hint).with(ZERO).and_call_original
      expect(console_game).to receive(:input_handle).once
      console_game.input_handle
    end
    it 'when the user use attempt for getting  `hint` && hitn is avilible', positive: true do
      allow(console_game).to receive(:check_hint).with(HINT).and_call_original
      expect(console_game).to receive(:view_hint).with(HINT).once
      console_game.view_hint(HINT)
    end
    it 'when the user  get answer `hint` to console', positive: true do
      allow(console_game).to receive(:view_hint).with(HINT).and_call_original
      expect(console_game.messages).to be_instance_of(Console)
    end
    it 'when user got hint and is getting offer do move', positive: true do
      allow(console_game).to receive(:view_hint).with(HINT).and_call_original
      expect(console_game).to receive(:user_game_move).once
      console_game.user_game_move
    end
    it 'when hint is used and value of current hint is changed', positive: true do
      allow(console_game).to receive(:view_hint).with(HINT).and_call_original
      puts console_game.current_hint
      puts console_game.messages
      a = console_game.instance_variable_get(:@current_hint)
      expect(a).to eq(HINT - 1) # :TODO don't get insatce v `current_hint`, BUT get `messages`
    end
  end

  context 'when the user attempt is `number`' do
    it 'when the user  attempt is `number`', positive: true do
      allow(console_game).to receive(:input_handle).with(NUMBER, HINT).and_call_original
      expect(game).to receive(:compare).once
      game.compare(NUMBER)
    end
    it 'when the user `number` was handled and returned a result', positive: true do
      allow(game).to receive(:compare).with(NUMBER).and_call_original
      expect(console_game.game_status).to be(String)
    end
    it 'when the user `number` was handled and attempt was used', positive: true do
      allow(console_game).to receive(:guess_result).and_return('NUMBER')
      expect(console_game.current_attempt).to eq(ATTEMPTS.last - 1)
    end
    it 'when the user `number` was handled and the game status is win', positive: true do
      allow(game).to receive(:compare).with(NUMBER).and_return(WIN)
      expect(console_game.messages).to receive(:game_over).once
      console_game.messages.game_over('secret_code', 'statistics', 'game_status')
    end
  end

  context 'when the user input is `exit`' do
    it 'when the user input is `exit`', positive: true do
      allow(console_game).to receive(:input_handle).with('exit', HINT).and_call_original
      expect(console_game.messages).to receive(:goodbye).once
      console_game.messages.goodbye
    end
  end

  context 'when the user input is NOT `exit` && `hint`' do
    it 'when the user input is NO `exit` &&  NO `hint`', positive: true do
      allow(console_game).to receive(:input_handle).with(NUMBER, HINT).and_call_original
      expect(console_game).to receive(:input_validate?).once # :TODO by using have received get the er:expected to have received input_validate?, but that object is not a spy or method has not been stubbed.
      console_game.input_validate?(NUMBER)
    end
  end
end
