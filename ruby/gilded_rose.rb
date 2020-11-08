class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Aged Brie"
        update_aged_brie_product(item)
      when "Backstage passes"
        update_backstage_passes_product(item)
      when "Sulfuras"
        ;
      when "Conjured"
        update_conjured_product(item)
      else
        update_normal_product(item)
      end
    end
  end

  private

  def update_conjured_product(item)
    item.quality -= 2
    item.quality_should_between_0_and_50
    item.decrease_sell_in
  end

  def update_aged_brie_product(item)
    item.quality += 1
    item.quality_should_between_0_and_50
    item.decrease_sell_in
  end

  def update_backstage_passes_product(item)
    item.quality += 1 * ((item.sell_in>10)? 1 : ((item.sell_in>5)? 2 : 3))
    item.quality = 0 if item.sell_in == 0
    item.quality_should_between_0_and_50
    item.decrease_sell_in
  end

  def update_normal_product(item)
    item.quality -= 1 * ((item.sell_in<=0)? 2 : 1)
    item.quality_should_between_0_and_50
    item.decrease_sell_in
  end

end

class Item
  attr_accessor :sell_in, :quality
  attr_reader :name

  def initialize(name, sell_in, quality)
    raise StandardError, 'Sulfuras quality must always be 80' if name == "Sulfuras" && quality != 80
    raise StandardError, 'Quality cannot be negative or larger then 50' if name != "Sulfuras" && (quality < 0 || quality > 50)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def quality_should_between_0_and_50
    @quality = [@quality, 0].max
    @quality = [@quality, 50].min
  end

  def decrease_sell_in
    @sell_in -= 1
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
