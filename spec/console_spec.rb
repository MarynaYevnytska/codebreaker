RSpec.describe Console do

  let!(:console) { described_class.new }
  context 'when gem run user see greeting message' do
    specify { expect { described_class.new }.to output(print(I18n.t('greeting'))).to_stdout }
  end

  context 'when an user input is valid' do

    it 'when user want to view statistics and press `stats`', positive: true do
      allow(console).to receive(:first_choice).and_return(Storage_constants::MENU[:yes])
      allow(console).to receive(:question).and_return(Storage_constants::MENU[:stats]).once
      allow(console).to receive(:first_choice).and_return(Storage_constants::MENU[:no])
      expect(STDOUT).to receive(:puts).with(I18n.t(Storage_constants::MENU[:statistics])).twice
      console.choice
    end
    it 'when user want to view rules  and press `rules`', positive: true do
      allow(console).to receive(:first_choice).and_return(Storage_constants::MENU[:yes])
      allow(console).to receive(:question).and_return(Storage_constants::MENU[:game_rules]).once
      allow(console).to receive(:first_choice).and_return(Storage_constants::MENU[:no])
      expect(console.choice).to receive(:puts).with(I18n.t(Storage_constants::MENU[:game_rules]))
      console.choice
    end
    it 'when user want to close app and press `goodbye`', positive: true do
      allow(console).to receive(:question).and_return(Storage_constants::MENU[:no])
      expect(STDOUT).to receive(:puts).with(I18n.t(Storage_constants::MENU[:goodbye]))
      console.first_choice
    end
    it 'when user want to continue  and press `y`', positive: true do
      allow(console).to receive(:question).and_return(Storage_constants::MENU[:yes])
      expect(STDOUT).to receive(:puts).with(I18n.t(Storage_constants::MENU[:choice]))
      console.first_choice
    end
  end

  context 'when an user input is wrong', positive: true do
    it 'when user input is INvalid' do
      allow(console).to receive(:question).and_return(Storage_constants::NUMBER)
      expect(STDOUT).to receive(:puts).with(I18n.t(Storage_constants::MENU[:choice]))
      console.choice
    end
    it 'when the start-menu was called and user can repeat an input', positive: true do
      allow(console).to receive(:question).and_return('wrong!')
      expect(STDOUT).to receive(:puts).with(I18n.t(Storage_constants::MENU[:wrong!]))
    end
    it 'when the start-menu 1 was called and user can repeat an input', positive: true do
    end
    it 'when the start-menu 2 was called and user can repeat an input', positive: true do
    end
    it 'when the start-menu 3 was called and user can repeat an input', positive: true do
    end
  end
end
