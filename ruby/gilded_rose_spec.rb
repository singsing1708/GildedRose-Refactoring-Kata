require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#Item.new" do
    context 'for Sulfuras' do
      it "raise error if quality is not 80" do
        expect {Item.new("Sulfuras", 10, 40)}.to raise_error('Sulfuras quality must always be 80')
      end
    end

    context 'for items ' do
      it "raise error if quality is negative" do
        expect {Item.new("foo", 10, -1)}.to raise_error('Quality cannot be negative')
      end
    end
  end

  describe "#update_quality" do
    subject { GildedRose.new(items).update_quality() }

    context 'when the item has sell_in 10 and quality 10' do
      let(:items) { [Item.new("foo", 10, 10)] }
      it "decrease sell_in and decrease quality" do
        subject
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 9
      end

    end

    context 'when the item has sell_in 10 and quality 0' do
      let(:items) { [Item.new("foo", 10, 0)] }
      it "quality will never be negative" do
        subject
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 0
      end
    end

    context 'when the item sell by date has passed' do
      let(:items) { [Item.new("foo", 0, 10)] }
      it "quality degrades twice as fast" do
        subject
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 8
      end
    end

    context 'when sell in decrease' do
      it "the quality never be 0" do
        items = [Item.new("Backstage passes", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0

        items = [Item.new("Conjured", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0

        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0
      end
    end

    context 'for Aged Brie, with sell_in 10 and quality 10' do
      let(:items) { [Item.new("Aged Brie", 10, 10)] }
      it "increases in Quality the older it gets" do
        subject
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 11
      end
    end

    context 'for Aged Brie and Backstage passes products, quality never more than 50' do
      it "increases in Quality the older it gets" do
        items = [Item.new("Aged Brie", 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 50

        items = [Item.new("Backstage passes", 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 50

        items = [Item.new("Backstage passes", 9, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 8
        expect(items[0].quality).to eq 50

        items = [Item.new("Backstage passes", 5, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 50
      end
    end

    context 'for Sulfuras' do
      it "never has to be sold or decreases in Quality, the quality is always 80" do
        items = [Item.new("Sulfuras", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
        expect(items[0].quality).to eq 80

        items = [Item.new("Sulfuras", 40, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 40
        expect(items[0].quality).to eq 80
      end
    end

    context 'for Backstage passes, with sell_in 11 and quality 40' do
      let(:items) { [Item.new("Backstage passes", 11, 40)] }
      it "increases in Quality by 1" do
        subject
        expect(items[0].sell_in).to eq 10
        expect(items[0].quality).to eq 41
      end
    end

    context 'for Backstage passes, with sell_in 10 and quality 40' do
      let(:items) { [Item.new("Backstage passes", 10, 40)] }
      it "increases in Quality by 2" do
        subject
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 42
      end
    end

    context 'for Backstage passes, with sell_in 5 and quality 40' do
      let(:items) { [Item.new("Backstage passes", 5, 40)] }
      it "increases in Quality by 3" do
        subject
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 43
      end
    end

    context 'for Backstage passes, with sell_in 0 and quality 40' do
      let(:items) { [Item.new("Backstage passes", 0, 40)] }
      it "quality will change to 0" do
        subject
        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0
      end
    end

    context 'for Conjured, with sell_in 10 and quality 40' do
      let(:items) { [Item.new("Conjured", 10, 40)] }
      it "will decrease the quality by 2" do
        subject
        expect(items[0].name).to eq "Conjured"
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 38
      end
    end

  end

end
