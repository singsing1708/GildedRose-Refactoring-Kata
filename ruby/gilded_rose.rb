class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Aged Brie"
        update_aged_brie_product(item)
      else
        update_normal_product(item)
      end
    end
  end

  private

  def update_aged_brie_product(item)
    item.quality += 1
    item.quality = [item.quality, 50].min
    item.sell_in -= 1
  end

  def update_normal_product(item)
    item.quality -= 1 * ((item.sell_in<=0)? 2 : 1)
    item.quality = [item.quality, 0].max
    item.quality = [item.quality, 50].min
    item.sell_in -= 1
  end


  def old_logic
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes"
        if item.quality > 0
          if item.name != "Sulfuras"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes"
            if item.quality > 0
              if item.name != "Sulfuras"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
