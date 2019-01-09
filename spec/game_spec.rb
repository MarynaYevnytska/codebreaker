DIFF = { "easy": { "name": 'Easy',
                   "difficulty": { "hints": 2, "attempts": 15 } },
         "medium": { "name": 'Medium',
                     "difficulty": { "hints": 1, "attempts": 10 } },
         "hell": { "name": 'Hell',
                   "difficulty": { "hints": 1, "attempts": 5 } } }.freeze
HINT = DIFF[:easy][:difficulty][:hints]
DIGIT = 4
NUMBER = '1' * DIGIT # 1111
NUM_RANGE = 6

RSpec.describe Game do
  let!(:game) { described_class.new(DIFF[:easy]) }
  let(:console_game) { Console_game.new('Maryna', DIFF[:easy]) }
  let!(:difficulty) { game.difficulty }
  let!(:secret_code) { game.secret_code }
  let!(:hint_clone_scode) { game.hint_clone_scode }

  context 'when the game started and datas move to processor' do
    it 'when the variable `difficulty` is exist', positive: true do
      expect(difficulty.class).to eq(Hash)
    end

    it 'when the variable `secret_code` is exist', positive: true do
      expect(secret_code.class).to eq(Array)
    end

    it 'when the variable `hint_clone_scode` is exist', positive: true do
      expect(hint_clone_scode.class).to eq(Array)
    end

    it 'when the digit of `secret_code` is correct', positive: true do
      expect(secret_code.size).to eq(DIGIT)
    end

    it 'when the digit of `secret_code` equal `hint_clone_scode` at the start', positive: true do
      expect(secret_code.size == hint_clone_scode.size).to eq(true)
    end

    it 'when the sequence of `secret_code` is not same as `hint_clone_scode`  at the start', positive: true do
      expect(game.hint_clone_scode).not_to eq(game.secret_code)
    end
  end

  context 'when user did a coorect input of number' do
    it 'when secret code equles user input, return game status `win`' do
      user_input = secret_code.join
      game.compare(user_input)
      expect(game.compare(user_input)).to eq(MESSAGE_GU[:win])
    end
  end

  context 'when the method plus-minus factoring output correct value' do
    [
      [[6, 5, 4, 1], [6, 5, 4, 1], '++++'],
      [[1, 2, 3, 4], [4, 3, 4, 3], '--'],
      [[1, 2, 3, 4], [2, 4, 3, 1], '+---'],
      [[1, 5, 3, 2], [5, 1, 3, 2], '++--'],
      [[1, 2, 3, 4], [1, 3, 2, 4], '++--'],
      [[1, 2, 3, 4], [1, 2, 4, 3], '++--'],
      [[1, 2, 3, 4], [1, 4, 2, 3], '+---'],
      [[1, 2, 3, 4], [4, 2, 1, 3], '+---'],
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
      [[5, 3, 3, 1], [3, 3, 1, 5], '+---']

    ].each do |item|
      it "when secret_code is #{item[0]} && the user input is #{item[1]}, the responds to consol will be #{item[2]}" do
        game.instance_variable_set(:@secret_code, item[0].join.chars)
        expect(game.compare(item[1].join)).to eq(item[2])
      end
    end
  end

  context 'when user get the hint' do
    it 'when hint is exists' do
      expect(game.hint).to be_instance_of(String)
    end

    it 'when  reminder after first hint is exists' do
      expect(game.hint_clone_scode).to be_instance_of(Array)
    end
  end

  it 'when  hint_clone_scode reduces reminder  after first hint by 1' do
    expect { game.hint }.to change { game.hint_clone_scode.size }.by(-1)
  end
end
