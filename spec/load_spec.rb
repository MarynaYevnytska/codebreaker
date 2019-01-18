# frozen_string_literal: true

RSpec.describe Load do
  let(:dummy_class) { Class.new { extend Load } }
  let(:list) { dummy_class.load_documents(Console::FILE_NAME_ST) }
  let(:rating) { dummy_class.rating(list) }
  context 'when datas crud' do
    before (:each) do
      stub_const('Console::FILE_NAME_ST', './spec/fixtures/stat.yml')
      end
      it '#save' do
        buffer = StringIO.new
        filename = Console::FILE_NAME_ST
        content = 'the content fo the file'
        allow(File).to receive(:open).with( filename, 'w').and_yield(buffer)
        File.open(filename, 'w') { |f| f.write(content) }
        expect(buffer.string).to eq(content)
      end
      it 'when use `load_documents` ' do
        stub_const('Console::FILE_NAME_ST', './spec/fixtures/stat.yml')
        expect(dummy_class.load_documents(Console::FILE_NAME_ST)).to be_instance_of(Array)
      end
      it 'when use `load_documents` ' do
        stub_const('Console::FILE_NAME_ST', './spec/fixtures/stat.yml')
        expect(dummy_class.load_statistics(Console::FILE_NAME_ST)).to be_instance_of(Array)
      end
      it 'when use `load_documents` ' do
        stub_const('Console::FILE_NAME_ST', './spec/fixtures/stat.yml')
        expect(dummy_class.load_statistics(Console::FILE_NAME_ST).empty?).to eq(false)
      end
  end
  context 'when storage is sorting' do
    it 'when storage is sorted by used attemts data type is correct' do
      expect(dummy_class.sorting_by_attemt(list)).to be_instance_of(Array)
    end
    it 'when storage is sorted by used attemts min=>max' do
      first_element = dummy_class.sorting_by_attemt(list)[0]
      last_element = dummy_class.sorting_by_attemt(list)[list.size - 1]
      expect(first_element[:attempts_used] < last_element[:attempts_used]).to eq(true)
    end
    it 'when storage is sorted by used hints' do
      expect(dummy_class.sorting_by_hint(list)).to be_instance_of(Array)
    end
    it 'when storage is sorted by used hints min=>max' do
      first_element = dummy_class.sorting_by_hint(list)[0]
      last_element = dummy_class.sorting_by_hint(list)[list.size - 1]
      expect(first_element[:hints_used] < last_element[:hints_used]).to eq(true)
    end
    it 'when storage is grupped by difficulty' do
      expect(dummy_class.groupping_by_difficulty(list)).to be_instance_of(Hash)
    end
    it 'when storage is sorted by used attemts && by used hints && grupped by difficulty and get hash' do
      expect(dummy_class.sorted(list)).to be_instance_of(Hash)
    end
    it 'when storage is sorted by used attemts && by used hints && grupped by difficulty' do
      expect((1..Console::DIFF.keys.size).cover?(dummy_class.sorted(list).keys.size)).to eq(true)
    end
  end
  context 'when storage unions by rating' do
    it 'when storage befor union by rating is exist' do
      expect(dummy_class.rating(list)).to be_instance_of(Array)
    end
    it 'when storage befor union by rating is exist' do
      expect(dummy_class.rating(list).empty?).to eq(false)
    end
    it 'when each item of storage after union by rating is exit' do
      expect(rating).to all(be_instance_of(Hash))
    end
  end
end
