public class GildedRose {
    var items:[Item]
    private let maxItemQuality = 50
    private let minItemQuality = 0
    
    public init(items:[Item]) {
        self.items = items
    }
    
    // TODO:
    // * Getting rid of magic numbers
    // * Remove repetitive if conditions
    // * Literal strings
    // * Extract repetitive functionality into methods
    // * Rename indexer form array of items
    // *
    
    private func incrementQualityBy1(_ item: Item) {
        if (item.quality < maxItemQuality) {
            item.quality = item.quality + 1
        }
    }
    
    private func decrementQualityBy1(_ item: Item) {
        if (item.quality > minItemQuality) {
            item.quality = item.quality - 1
        }
    }
    
    public func updateQuality() {
        for item in items {
            if (item.name == "Sulfuras, Hand of Ragnaros") {
                continue
            }

            if (item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert") {
                decrementQualityBy1(item)
            } else {
                if (item.quality < maxItemQuality) {
                    item.quality = item.quality + 1
                    
                    if (item.name == "Backstage passes to a TAFKAL80ETC concert") {
                        if (item.sellIn < 11) {
                            incrementQualityBy1(item)
                        }
                        
                        if (item.sellIn < 6) {
                            incrementQualityBy1(item)
                        }
                    }
                }
            }
            
            item.sellIn = item.sellIn - 1
            
            if (item.sellIn < 0) {
                if (item.name == "Aged Brie") {
                    incrementQualityBy1(item)
                } else {
                    if (item.name != "Backstage passes to a TAFKAL80ETC concert") {
                        if (item.quality > minItemQuality) {
                            item.quality = item.quality - 1
                        }
                    } else {
                        item.quality = item.quality - item.quality
                    }
                }
            }
        }
    }
}
