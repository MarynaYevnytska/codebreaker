RSpec.describe Console do
  let (:console) { described_class.new(nil) }
  let (:easy) { console.difficulty_registration('easy') }
  let (:medium) { console.difficulty_registration('medium') }
  let (:hell) { console.difficulty_registration('hell') }
  # let (:wrong) { console.difficulty_registration('smt') }

  context 'when gem run user see greeting message' do
    specify { expect { described_class.new }.to output(print(I18n.t('greeting'))).to_stdout }
  end

  context 'when an user input is valid' do
    it 'when user want to continue  and press `y`', positive: true do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:yes])
      expect(console).to receive(:choose_the_command).once
      console.choose_the_command
    end
    it 'when user want to view rules  and press `rules`', positive: true do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:game_rules])
      expect(console).to receive(:rules).once
      console.rules
    end
    context 'when user want to view statistics and press `stats`' do
      it 'when user want to view statistics and press `stats`', positive: true do
        allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:stats])
        expect(console).to receive(:stats).once
        console.stats
      end
      it 'when method for print statistics data is called', positive: true do
        allow(console).to receive(:stats).and_call_original
        expect(console).to receive(:print_statistic).once
        console.print_statistic
      end
      it 'when datas from file is got', positive: true do
        allow(console).to receive(:stats).and_call_original
        expect(console.print_statistic).to be_instance_of(Array)
      end
      it 'when datas from file is hash', positive: true do
        allow(console).to receive(:stats).and_call_original
        expect(console.print_statistic[0]).to be_instance_of(Hash)
      end
    end

    it 'when user want to start and press `start`', positive: true do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:game_start])
      expect(console).to receive(:start).once
      console.start
    end
    it 'when user want to exit and press `exit`', positive: true do
      allow(console).to receive(:choice).with(console.question {}).and_return(Console::MENU[:exit])
      expect(console).to receive(:goodbye).once
      console.goodbye
    end
  end

  context 'when an user input is wrong', positive: true do
    context 'when an alert message was outputed ' do
      specify { expect { described_class.new(Console::MENU[:wrong_choice]) }.to output(print(I18n.t(Console::MENU[:wrong_choice]))).to_stdout }
    end

    it 'when the start-menu was called and user can repeat an input', positive: true do
      allow(console).to receive(:choice).with(console.question {}).and_return('wrong!')
      expect(console).to receive(:choose_the_command).once
      console.choose_the_command
    end
  end

  context 'when game start' do
    it 'when a difficulty was chosen', positive: true do
      expect(easy).to eq(Console::DIFF[:easy])
      expect(medium).to eq(Console::DIFF[:medium])
      expect(hell).to eq(Console::DIFF[:hell])
    end
    it 'when a data type of difficulty is correct', positive: true do
      expect(easy.class).to eq(Hash)
      expect(medium.class).to eq(Hash)
      expect(hell.class).to eq(Hash)
    end
    it 'when a volume of difficulty is correct', positive: true do
      expect(easy.size).to eq(2)
      expect(medium.size).to eq(2)
      expect(hell.size).to eq(2)
    end
    it 'when all the values of difficulty are exist', positive: true do
      expect(easy.values.compact.size).to eq(2)
      expect(medium.values.compact.size).to eq(2)
      expect(hell.values.compact.size).to eq(2)
    end
    it 'when all the values of difficulty are full', positive: true do
      expect(easy[:difficulty].values.compact.size).to eq(2)
      expect(medium[:difficulty].values.compact.size).to eq(2)
      expect(hell[:difficulty].values.compact.size).to eq(2)
    end
    it 'when an user inputs a wrong name of difficulty', positive: true do
      allow(console).to receive(:difficulty_registration).with('smt').and_call_original
      expect(console).to receive(:choose_the_difficulty).once
      console.choose_the_difficulty
    end
  end
end
