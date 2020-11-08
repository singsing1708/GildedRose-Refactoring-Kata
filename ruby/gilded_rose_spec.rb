require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    subject { GildedRose.new(items).update_quality() }
    context 'when the item has sell_in 10 and quality 10' do
      let(:items) { [Item.new("foo", 10, 10)] }
      it "does not change the name, decrease sell_in and decrease quality" do
        subject
        expect(items[0].name).to eq "foo"
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 9
      end

      it "quality will never be negative" do
        items = [Item.new("foo", 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 0
      end
    end

    context 'when the item sell by date has passed' do
      let(:items) { [Item.new("foo", 0, 10)] }
      it "Quality degrades twice as fast" do
        subject
        expect(items[0].name).to eq "foo"
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 8
      end
    end

  end

end
