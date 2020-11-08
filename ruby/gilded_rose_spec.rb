require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name, decrease sell_in and decrease quality" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 9
    end
  end

  describe "#update_quality" do
    it "quality will never be negative" do
      items = [Item.new("foo", 10, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 0
    end
  end

end
