RSpec.describe Game do
  let(:game) { described_class.new(Console::DIFF[:medium]) }
  let(:console_game) { Console_game.new('Sergey', Console::DIFF[:medium]) }
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

    it 'when the sequence of `secret_code` is not same as `hint_clone_scode` at the start', positive: true do
      expect(@secret_code === @hint_clone_scode).to eq(false)
    end
  end
  context 'Comaring user input' do
    it 'when user won, return game status WIN' do
      allow(game).to receive(:compare).with(game.secret_code.join).and_call_original
      expect(game.compare(game.secret_code.join) == Console::MESSAGE_GU[:win]).to eq(true)
    end
    it 'when user input differen with  secret code, return game status WIN' do
      allow(game).to receive(:compare).with(NUMBER).and_call_original
      expect(game.compare(NUMBER)).to receive(:plus_minus_factoring).with(NUMBER).once
      game.plus_minus_factoring(NUMBER)
    end
  end
  context 'when user get the hint' do
    it 'when  reminder after first hint is correct' do
      allow(game).to receive(:get_hint).once.and_call_original
      expect(game.hint_clone_scode.size).to eq(3)
    end
    it 'when  reminder after second hint is correct' do
      allow(game).to receive(:get_hint).twice.and_call_original
      expect(game.hint_clone_scode.size).to eq(2)
    end
  end
  context 'result of plus-minus factoring' do
    [
      [[6, 5, 4, 1], [6, 5, 4, 1], '++++'],
      [[1, 5, 3, 2], [5, 1, 3, 2], '++--'],
      [[1, 2, 3, 4], [1, 3, 2, 4], '++--'],
      [[1, 2, 3, 4], [1, 2, 4, 3], '++--'],
      [[1, 2, 3, 4], [1, 4, 2, 3], '+---'],
      [[1, 2, 3, 4], [4, 2, 1, 3], '+---'],
      [[1, 2, 3, 4], [2, 4, 3, 1], '+---'],
      [[1, 2, 3, 4], [2, 3, 1, 4], '+---'],
      [[1, 2, 3, 4], [4, 3, 2, 1], '----'],
      [[5, 4, 3, 2], [2, 3, 4, 5], '----'],
      [[1, 2, 3, 4], [2, 1, 4, 3], '----'],
      [[1, 3, 4, 2], [1, 2, 3, 4], '+---'],
      [[5, 2, 5, 5], [2, 5, 5, 5], '++--'],
      [[5, 5, 2, 5], [2, 5, 5, 5], '++--'],
      [[5, 5, 5, 2], [2, 5, 5, 5], '++--'],
      [[6, 2, 6, 2], [2, 6, 2, 6], '----'],
      [[6, 6, 2, 2], [2, 6, 2, 6], '++--'],
      [[2, 2, 6, 6], [2, 6, 2, 6], '++--'],
      [[2, 6, 6, 2], [2, 6, 2, 6], '++--'],
      [[6, 2, 2, 6], [2, 6, 2, 6], '++--'],
      [[3, 1, 3, 5], [3, 3, 1, 5], '++--'],
      [[3, 5, 1, 3], [3, 3, 1, 5], '++--'],
      [[3, 3, 5, 1], [3, 3, 1, 5], '++--'],
      [[1, 3, 5, 3], [3, 3, 1, 5], '+---'],
      [[5, 3, 1, 3], [3, 3, 1, 5], '++--'],
      [[1, 5, 3, 3], [3, 3, 1, 5], '----'],
      [[5, 3, 3, 1], [3, 3, 1, 5], '+---'],
      [[1, 2, 3, 4], [4, 3, 4, 3], '--']
    ].each do |item|
      it "when secret_code is #{item[0]} && the user input is #{item[1]}, the responds to consol will be #{item[2]}" do
        game.instance_variable_set(:@secret_code, item[0])
        allow(game).to receive(:plus_minus_factoring).and_call_original
        expect(game.plus_minus_factoring(item[1].join)).to eq(item[2])
      end
    end
  end
end
