share_examples_for 'a slugged model' do
  
  let(:slug_source) { described_class.slug_source }
  
  it 'should have a slugged field' do
    described_class.should respond_to(:slug_source)
  end
  
  it 'should define slugged finders' do
    described_class.should respond_to(:find_using_slug)
    described_class.should respond_to(:find_using_slug!)
  end
  
  it 'should record preview versions of slugs' do
    described_class.use_slug_history.should be_true
  end
  
  it 'should let you check if you need to generate a slug' do
    subject.should respond_to(:should_generate_slug?)
  end
  
  it 'should return the slug via to_param' do
    described_class.use_slug_to_param.should be_true
  end
  
  it 'should let you force the generation of a slug' do
    object = described_class.new(slug_source => "Random Data")
    mock(object).generate_slug
    mock(object).save :validate => false
    object.generate_slug!
  end
  
end