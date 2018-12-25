RSpec.describe Console_game do
  let(:console_game) { described_class.new('Sergey', Console::DIFF[:medium]) }

  context '#initialize' do
    before(:each) do
      @name = console_game.name
      @difficulty = console_game.difficulty
      @messages = console_game.messages
      @game = console_game.game
    end
    it 'when the variable `name` is exist' do
      expect(@name.class).to eq(String)
    end
    it 'when the variable `difficulty` is exist' do
      expect(@difficulty.class).to eq(Hash)
    end
    it 'check the size of difficulty' do
      expect(@difficulty.size).to eq(2)
      expect(@difficulty[:difficulty].size).to eq(2)
    end
    it 'when the variable `messages` is exist' do
      expect(@messages.class).to eq(Console)
    end
    it 'when the variable `game` is exist' do
      expect(@game.class).to eq(Game)
    end
    it 'when the value of difficulty moved from console_game to game' do
      expect(@difficulty === @game.difficulty).to eq(true)
    end
  end

  context 'when game params is valid. Start.POSITIVE' do
    before(:each) do
      allow(console_game).to receive(:game_progress).and_return('hint')
      console_game.game_progress
    end

    it 'when current attemt is valid.Start' do
      expect(console_game.current_attempt === 1).to eq(false) # TODO
    end
    it 'when current hint is valid at start game' do
      expect(console_game.current_hint).to eq(Console::DIFF[:medium][:difficulty][:hint])
    end
  end

  context 'when game params POSITIVE by first attempt' do
    it 'check value of variable current_hint'
    it 'check value of variable current_attempt'
  end

  context 'check consol_response' do
    it 'when consol_response is hint && current hint is zero'
    it 'when consol_response is hint && current hint is not zero'
    it 'when consol_response is exit'
    it 'when consol_response is number'
  end
end
