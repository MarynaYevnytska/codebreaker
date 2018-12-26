RSpec.describe Game do
  let(:game) { described_class.new(Console::DIFF[:medium]) }
  context '#initialize' do
    before(:each) do
      @difficulty = game.difficulty
      @secret_code = game.create_secret_code
      @hint_clone_scode = @secret_code.shuffle
    end
    it 'when the variable `difficulty` is exist', positive: true do
      expect(@difficulty.class).to eq(Hash)
    end
    it 'when the variable `secret_code` is exist', positive: true do
      expect(@secret_code.class).to eq(Array)
    end
    it 'when the variable `hint_clone_scode` is exist', positive: true do
      expect(@hint_clone_scode.class).to eq(Array)
    end
    it 'when the digit of `secret_code` is correct', positive: true do
      expect(@secret_code.size).to eq(Game::DIGIT)
    end
    it 'when the digit of `secret_code` equal `hint_clone_scode` at the start', positive: true do
      expect(@secret_code.size == @hint_clone_scode.size).to eq(true)
    end
  end
end
