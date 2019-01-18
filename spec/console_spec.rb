RSpec.describe Console do

  let!(:console) { described_class.new }
  let!(:console_game) { ConsoleGame.new('Maryna',DIFF[:easy]) }
  let!(:yes){MENU[:yes]}
  let!(:start){MENU[:start]}
  let!(:stats){MENU[:statistics]}
  let(:s_code){[1,1,1,1]}
  let(:game_statistics) {instatnce_of_(Hash)}

  context 'when gem run user see greeting message' do
    specify { expect { described_class.new }.to output(print(I18n.t('greeting'))).to_stdout }
  end
  it 'when user get answer to console' do
    allow(console).to receive(:answer_for_user).with('anything').once
    expect(STDOUT).to receive(:puts).with('anything').once
  end
  it 'when user get message and should input  answer  to console' do
    expect(STDOUT).to receive(:print ).with("anything?")
    allow(STDIN).to receive(:gets) { 'joe' }
    expect(console.question).to eq 'Joe'
  end
  it 'when user get message and should input  answer  to console' do
    allow(console).to receive(:question).with('anything').once
    expect(STDOUT).to receive(:print ).with("anything?")
  end
  context 'whe game over' do
    before(:each) do
      allow(console).to receive(:game_over).with(s_code, game_statistics)
    end
    it 'when user watch message about game over ' do
      expect(STDOUT).to receive(:print ).with("Secret code is #{s_code.join}")
      console.game_over(s_code, game_statistics)
    end
    it 'when user watch message about game over with status "win"' do
      game_status = 'win'
      expect(STDOUT).to receive(:print ).with("Secret code is #{s_code.join}")
      console.game_over(s_code, game_statistics)
    end
  end
  context 'when user choosen game start and  press `start`' do
    before (:each) do
      allow(console).to receive(:first_choice).and_return(yes)
      allow(console).to receive(:question).and_return(start).once
    end
    it 'when  method call' do
      expect(console).to receive(:start).once
      console.choice
    end
    it 'when insatance of game was created and name write down' do
      expect(console).to receive(:name).once
      console.start
    end
    it 'when insatance of game was created and name write down' do
      expect(console).to receive(:difficulty_choice).once
      console.start
    end
    it 'when insatance of game was created and name write down' do
      expect(console_game).to receive(:game_progress).once
      console.start
    end
  end
  context 'when an user input is valid' do
    it 'when user want to view statistics and press `stats`', positive: true do
      allow(console).to receive(:first_choice).and_return(yes)
      allow(console).to receive(:question).and_return(stats).once
      allow(console).to receive(:first_choice).and_return(MENU[:no])
      expect(STDOUT).to receive(:puts).with(I18n.t(stats)).twice
      console.choice
    end
    it 'when user want to view rules  and press `rules`', positive: true do
      allow(console).to receive(:first_choice).and_return(yes)
      allow(console).to receive(:question).and_return(MENU[:game_rules]).once
      allow(console).to receive(:first_choice).and_return(MENU[:no])
      expect(console.choice).to receive(:puts).with(I18n.t(MENU[:game_rules]))
      console.choice
    end
    it 'when user want to close app and press `goodbye`', positive: true do
      allow(console).to receive(:question).and_return(MENU[:no])
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:goodbye]))
      console.first_choice
    end
    it 'when user want to continue  and press `y`', positive: true do
      allow(console).to receive(:question).and_return(yes)
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:choice]))
      console.first_choice
    end
  end
  context 'when an user input is wrong', positive: true do
    it 'when user input is INvalid' do
      allow(console).to receive(:question).and_return('1111')
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:choice]))
      console.choice
    end
    it 'when the start-menu was called and user can repeat an input', positive: true do
      allow(console).to receive(:question).and_return('wrong!')
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:wrong!]))
    end
  end
end
