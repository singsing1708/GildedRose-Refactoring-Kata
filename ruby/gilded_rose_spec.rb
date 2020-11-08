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

    end

    context 'when the item has sell_in 10 and quality 0' do
      let(:items) { [Item.new("foo", 10, 0)] }
      it "quality will never be negative" do
        subject
        expect(items[0].name).to eq "foo"
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 0
      end
    end

    context 'when the item sell by date has passed' do
      let(:items) { [Item.new("foo", 0, 10)] }
      it "quality degrades twice as fast" do
        subject
        expect(items[0].name).to eq "foo"
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 8
      end
    end

    context 'for Aged Brie, with sell_in 10 and quality 10' do
      let(:items) { [Item.new("Aged Brie", 10, 10)] }
      it "increases in Quality the older it gets" do
        subject
        expect(items[0].name).to eq "Aged Brie"
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 11
      end
    end

  end

end
