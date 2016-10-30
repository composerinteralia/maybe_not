require 'maybe'

describe Maybe do
  context "when called with nil" do
    let(:nothing) { Maybe(nil) }

    it "returns a Nothing" do
      expect(nothing).to be_a(Maybe::Nothing)
    end
  end

  context "when called with a non-nil value" do
    let(:something) { Maybe(:something) }

    it "returns a something" do
      expect(something).to be_a(Maybe::Something)
    end
  end
end
