RSpec.describe Console do
  let (:console) { described_class.new(nil) }

  context 'when gem run user see greeting message' do
    specify { expect { Console.new }.to output(print(I18n.t('greeting'))).to_stdout }
  end
  context 'when an user input is valid _POSITIVE' do
    it 'if user want to continue  and press `y`' do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:yes])
      expect(console).to receive(:choose_the_command).once
      console.choose_the_command
    end
    it 'if user want to view rules  and press `rules`' do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:game_rules])
      expect(console).to receive(:rules).once
      console.rules
    end
    it 'if user want to view statistics and press `stats`' do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:stats])
      expect(console).to receive(:stats).once
      console.stats
    end
    it 'if user want to start and press `start`' do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:game_start])
      expect(console).to receive(:start).once
      console.start
    end

    it 'if user want to exit and press `exit`' do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:exit])
      expect(console).to receive(:goodbye).once
      console.goodbye
    end
  end

  context 'if an user input is wrong _NEGATIVE' do
    context 'check an alert output message' do
      specify { expect { Console.new(Console::MENU[:wrong_choice]) }.to output(print(I18n.t(Console::MENU[:wrong_choice]))).to_stdout }
    end
    it 'check, that will call the start-menu' do
      allow(console).to receive(:choice).with(console.question {}).and_return('wrong!')
      expect(console).to receive(:choose_the_command).once
      console.choose_the_command
    end
  end
  context 'when game start' do
    before(:each) do
      @easy = console.difficulty_registration('easy')
      @medium = console.difficulty_registration('medium')
      @hell = console.difficulty_registration('hell')
    end
    it 'check, a difficulty was chosen?' do
      expect(@easy).to eq(Console::DIFF[:easy])
      expect(@medium).to eq(Console::DIFF[:medium])
      expect(@hell).to eq(Console::DIFF[:hell])
    end
    it 'check, a  variable difficulty is hash?' do
      expect(@easy.class).to eq(Hash)
      expect(@medium.class).to eq(Hash)
      expect(@hell.class).to eq(Hash)
    end

    it 'check, a size of hash for  variable difficulty' do
      expect(@easy.size).to eq(2)
      expect(@medium.size).to eq(2)
      expect(@hell.size).to eq(2)
    end
    it 'check, all the values of hash are exist' do
      expect(@easy.values.compact.size).to eq(2)
      expect(@medium.values.compact.size).to eq(2)
      expect(@hell.values.compact.size).to eq(2)
      expect(@easy[:difficulty].values.compact.size).to eq(2)
      expect(@medium[:difficulty].values.compact.size).to eq(2)
      expect(@hell[:difficulty].values.compact.size).to eq(2)
    end

    it 'when an user enters a wrong name of difficulty' do
      allow(console).to receive(:difficulty_registration).with(console.choose_the_difficulty).and_return('SMT')
      expect(console).to receive(:choose_the_difficulty).once
      console.choose_the_difficulty
    end
  end
end
