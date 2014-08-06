shared_examples_for "a node" do
  describe "callbacks" do
    describe "#calculate_full_path" do
      it "calculates the full path based on the parent" do
        subject.parent = Ilohv::Directory.create(name: 'foo')
        subject.name = 'bar'

        subject.valid?

        expect(subject.full_path).to eq "foo/#{subject.name}"
      end
    end
  end

  describe "scopes" do
    describe "default scope" do
      it "orders nodes by name" do
        foo = described_class.create(name: 'foo')
        bar = described_class.create(name: 'bar')

        all = described_class.all
        expect(all.index(bar) < all.index(foo)).to eq true
      end
    end
  end
end
