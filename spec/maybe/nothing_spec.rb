require 'maybe/nothing'

describe Maybe::Nothing do
  subject { Maybe::Nothing.instance }

  describe "#else" do
    let(:some_value) { "some value" }

    it "returns the value of the executed block" do
      expect(subject.else { some_value }).to be(some_value)
    end
  end

  describe "#get" do
    it "raises NothingToSeeHere" do
      expect { subject.get }.to raise_error(
        Maybe::Nothing::NothingToSeeHere, "called 'get' on Nothing"
      )
    end
  end

  describe "#nothing?" do
    it "returns true" do
      expect(subject).to be_nothing
    end
  end

  describe "#something?" do
    it "returns false" do
      expect(subject).not_to be_something
    end
  end

  describe "#method_missing" do
    it "returns the same Nothing for chaining" do
      [:a, :b, :c].each do |method|
        expect(subject).to receive(:method_missing)
          .with(method)
          .and_call_original
      end

      expect(subject.a.b.c).to be(subject)
    end
  end
end
