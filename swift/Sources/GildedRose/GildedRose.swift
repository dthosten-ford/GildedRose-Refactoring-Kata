public class GildedRose {
    var items:[Item]
    let minQuality = 0
    let maxQuality = 50
    
    public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        for i in 0..<items.count {
            /*
             1) Too much nested if statement
             2) hard to understand and scattered logic
             3) needs methods to do the operations
             4) items[i] can be moved to a constant
             5) magic numbers with no explanation
             6) repeatitive conditions
             7) literals in the code
             8) literals are way to specified than the business rules
             9)
             */
            
            if (items[i].name != "Aged Brie" && items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                if (items[i].quality > minQuality) {
                    if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                        items[i].quality = items[i].quality - 1
                    }
                }
            } else {
                if (items[i].quality < maxQuality) {
                    items[i].quality = items[i].quality + 1
                    
                    if (items[i].name == "Backstage passes to a TAFKAL80ETC concert") {
                        if (items[i].sellIn < 11) {
                            if (items[i].quality < maxQuality) {
                                items[i].quality = items[i].quality + 1
                            }
                        }
                        
                        if (items[i].sellIn < 6) {
                            if (items[i].quality < maxQuality) {
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
                        if (items[i].quality > minQuality) {
                            if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                                items[i].quality = items[i].quality - 1
                            }
                        }
                    } else {
                        items[i].quality = items[i].quality - items[i].quality
                    }
                } else {
                    if (items[i].quality < maxQuality) {
                        items[i].quality = items[i].quality + 1
                    }
                }
            }
        }
    }
}
