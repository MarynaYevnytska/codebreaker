RSpec.describe Console do
  let!(:console) { described_class.new }

  context 'when gem run user see greeting message' do
    specify { expect { described_class.new }.to output(print(I18n.t('greeting'))).to_stdout }
  end

  context 'when an user input is valid' do
    it 'when user want to view statistics and press `stats`' do
      allow(console).to receive(:question).and_return(MENU[:stats])
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:statistics]))
      console.choice
    end
    it 'when user want to view rules  and press `rules`' do
      allow(console).to receive(:question).and_return(MENU[:game_rules])
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:game_rules]))
      console.choice
    end
    it 'when user want to close app and press `goodbye`' do
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:goodbye]))
      console.choice
    end
    it 'when user want to continue  and press `y`', positive: true do
      allow(console).to receive(:question).and_return(MENU[:yes])
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:choice]))
      console.choice
    end
  end

  context 'when an user input is wrong', positive: true do
    it 'when user input is INvalid' do
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:choice]))
      console.choice
    end
    it 'when the start-menu was called and user can repeat an input', positive: true do
      allow(console).to receive(:choice).and_return('wrong!')
      expect(STDOUT).to receive(:puts).with(I18n.t(MENU[:wrong!]))
    end
  end
end
