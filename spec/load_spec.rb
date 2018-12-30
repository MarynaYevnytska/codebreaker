SIZE=7 # position data base for each game
RSpec.describe Load do
  let(:dummy_class) { Class.new { extend Load } }
  let(:list){dummy_class.load_documents(FILE_NAME_ST)}

  it 'when use `load_documents` ' do
    allow(dummy_class).to receive(:load_documents).with(FILE_NAME_ST).and_call_original
    list=dummy_class.load_documents(FILE_NAME_ST)
    expect(dummy_class.load_documents(FILE_NAME_ST)).to be_instance_of(Array)
  end

  context 'when storage is sorting' do
  it 'when storage is sorted by used attemts data type is correct' do
    allow(dummy_class).to receive(:sorting_by_attemt).with(list).and_call_original
    expect(dummy_class.sorting_by_attemt(list)).to be_instance_of(Array)
  end
  it 'when storage is sorted by used attemts min=>max' do
    allow(dummy_class).to receive(:sorting_by_attemt).with(list).and_call_original
    first_element=dummy_class.sorting_by_attemt(list)[0]
    last_element=dummy_class.sorting_by_attemt(list)[list.size-1]
    expect(first_element[:attempts_used] < last_element[:attempts_used]).to eq(true)
  end
  it 'when storage is sorted by used hints' do
    allow(dummy_class).to receive(:sorting_by_hint).with(list).and_call_original
    expect(dummy_class.sorting_by_hint(list)).to be_instance_of(Array)
  end
  it 'when storage is sorted by used hints min=>max' do
    allow(dummy_class).to receive(:sorting_by_hint).with(list).and_call_original
    first_element=dummy_class.sorting_by_hint(list)[0]
    last_element=dummy_class.sorting_by_hint(list)[list.size-1]
    expect(first_element[:hints_used] < last_element[:hints_used]).to eq(true)
  end

  it 'when storage is grupped by difficulty' do
    allow(dummy_class).to receive(:groupping_by_difficulty).with(list).and_call_original
    expect(dummy_class.groupping_by_difficulty(list)).to be_instance_of(Hash)
  end
  it 'when storage is sorted by used attemts && by used hints && grupped by difficulty' do
    allow(dummy_class).to receive(:sorted).with(list).and_call_original
    expect(dummy_class.sorted(list)).to be_instance_of(Hash)
  end
  it 'when storage is sorted by used attemts && by used hints && grupped by difficulty' do
    allow(dummy_class).to receive(:sorted).with(list).and_call_original
    expect((1..Console::DIFF.keys.size).cover?(dummy_class.sorted(list).keys.size)).to eq(true)
  end
  context 'when storage unions by rating' do
    before do
      allow(dummy_class).to receive(:rating).with(list).and_call_original
      @rating=dummy_class.rating(list)
    end
    it 'when storage befor union by rating is exist' do
      expect(@rating).to be_instance_of(Array)
    end
    it 'when each item of storage after union by rating is exit' do
      @rating.each{|item| expect(item).to be_instance_of(Hash)}
    end
    it 'when each item-size is correct' do
      @rating.each{|item| expect(item.size).to eq(SIZE)}
    end
end
end
end
