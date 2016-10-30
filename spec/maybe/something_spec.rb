require 'maybe/something'

describe Maybe::Something do
  subject(:something) { Maybe::Something.new("Some Value") }

  describe "#else" do
    it "returns the value" do
      expect(subject.else).to eq("Some Value")
    end
  end

  describe "#get" do
    it "returns the value" do
      expect(subject.get).to eq("Some Value")
    end
  end

  describe "#if_something" do
    it "executes the block with the value" do
      expect do |block|
        subject.if_something(&block)
      end.to yield_with_args("Some Value")
    end

    it "returns the same Something for chaining" do
      expect(subject.if_something {}).to be(something)
    end
  end

  describe "#nothing?" do
    it "returns false" do
      expect(subject).not_to be_nothing
    end
  end

  describe "#something?" do
    it "returns true" do
      expect(subject).to be_something
    end
  end

  describe "#method_missing" do
    let(:spy_value)     { double(:some_value) }
    let(:spy_something) { Maybe::Something.new(spy_value) }

    it "calls the method on the value" do
      expect(spy_value).to receive(:some_method).with(:arg)
      spy_something.some_method(:arg)
    end

    context "when the value responds" do
      context "with nil" do
        it "returns a Nothing" do
          expect(subject[100]).to be_nothing
        end
      end

      context "with a non-nil value" do
        it "returns a new Something" do
          new_something = subject.upcase

          expect(new_something).to be_something
          expect(new_something).not_to be(subject)
        end

        it "commutes with #get" do
          expect(subject.get.upcase).to eq(subject.upcase.get)
        end
      end
    end

    context "when the value does not respond" do
      it "raises a NoMethodError" do
        expect { something.no_method }.to raise_error(NoMethodError)
      end
    end
  end
end
