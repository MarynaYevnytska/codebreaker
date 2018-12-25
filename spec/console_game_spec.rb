RSpec.describe Console_game do
  # before(:each)do
  # @console_game=Console_game.new('name', 'difficulty')
  # end
  context '#initialize' do
    it 'check class of name '
    it 'check class of difficulty'
    it 'check size of difficulty'
    it 'check class of messages'
    it 'check class of game'
  end

  context 'when game params POSITIVE or start ' do
    it 'check value of variable current_hint'
    it 'check value of variable current_attempt'
  end

  context 'when game params POSITIVE by first attemt' do
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
