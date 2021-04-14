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
    
    public func updateQuality() {
        for i in 0..<items.count {
            if (items[i].name != "Aged Brie" && items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                if (items[i].quality > minItemQuality) {
                    if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                        items[i].quality = items[i].quality - 1
                    }
                }
            } else {
                if (items[i].quality < maxItemQuality) {
                    items[i].quality = items[i].quality + 1
                    
                    if (items[i].name == "Backstage passes to a TAFKAL80ETC concert") {
                        if (items[i].sellIn < 11) {
                            if (items[i].quality < maxItemQuality) {
                                items[i].quality = items[i].quality + 1
                            }
                        }
                        
                        if (items[i].sellIn < 6) {
                            if (items[i].quality < maxItemQuality) {
                                items[i].quality = items[i].quality + 1
                            }
                        }
                    }
                }
            }
            
            if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                items[i].sellIn = items[i].sellIn - 1
            }
            
            if (items[i].sellIn < 0) {
                if (items[i].name != "Aged Brie") {
                    if (items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                        if (items[i].quality > minItemQuality) {
                            if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                                items[i].quality = items[i].quality - 1
                            }
                        }
                    } else {
                        items[i].quality = items[i].quality - items[i].quality
                    }
                } else {
                    if (items[i].quality < maxItemQuality) {
                        items[i].quality = items[i].quality + 1
                    }
                }
            }
        }
    }
}
