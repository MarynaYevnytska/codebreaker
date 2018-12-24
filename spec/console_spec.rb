RSpec.describe Console do
let (:console) {described_class.new(nil)}
context "when gem run user see greeting message" do
  specify { expect { Console.new }.to output(print I18n.t('greeting')).to_stdout }
end
context "when an user input is valid _POSITIVE" do
    it "if user want to continue  and press `y`" do
    allow(console).to receive(:choice).with(console.question{}).and_return(Console::MENU[:yes])
    expect(console).to receive(:choose_the_command).once
    console.choose_the_command
    end
    it "if user want to view rules  and press `rules`"do
    allow(console).to receive(:choice).with(console.question{}).and_return(Console::MENU[:game_rules])
    expect(console).to receive(:rules).once
    console.rules
    end
    it "if user want to view statistics and press `stats`"do
    allow(console).to receive(:choice).with(console.question{}).and_return(Console::MENU[:stats])
    expect(console).to receive(:stats).once
    console.stats
    end
    it "if user want to start and press `start`" do
    allow(console).to receive(:choice).with(console.question{}).and_return(Console::MENU[:game_start])
    expect(console).to receive(:start).once
    console.start
    end

    it "if user want to exit and press `exit`" do
    allow(console).to receive(:choice).with(console.question{}).and_return(Console::MENU[:exit])
    expect(console).to receive(:goodbye).once
    console.goodbye
    end
  end

  context "if an user input is wrong _NEGATIVE" do
    it "check messge" do
    end
    it "check a call back the start-menu" do
    end
  end
end
