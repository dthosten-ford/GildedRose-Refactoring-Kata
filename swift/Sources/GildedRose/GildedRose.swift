public class GildedRose {
    var items:[Item]
    let minQuality = 0
    let maxQuality = 50
    
    public init(items:[Item]) {
        self.items = items
    }
    
    fileprivate func incrementQltyIfLessThanMaxQlty(_ item: Item) {
        if (item.quality < maxQuality) {
            item.quality = item.quality + 1
        }
    }
    
    fileprivate func decrementQltyIfGreaterThanMinQlty(_ item: Item) {
        if (item.quality > minQuality) {
            item.quality = item.quality - 1
        }
    }
    
    public func updateQuality() {
        for item in items {
            /*
             1) Too much nested if statement
             2) hard to understand and scattered logic
             3) needs methods to do the operations
             4) item can be moved to a constant
             5) magic numbers with no explanation
             6) repeatitive conditions
             7) literals in the code
             8) literals are way to specified than the business rules
             */
            guard item.name != "Sulfuras, Hand of Ragnaros" else { continue }
            
            if item.name == "Aged Brie" {
                incrementQltyIfLessThanMaxQlty(item)
                item.sellIn = item.sellIn - 1
                
                if(item.sellIn < 0) {
                    incrementQltyIfLessThanMaxQlty(item)
                }
                continue
            }

            if item.name == "Backstage passes to a TAFKAL80ETC concert" {
                incrementQltyIfLessThanMaxQlty(item)
                if (item.sellIn < 11) {
                    incrementQltyIfLessThanMaxQlty(item)
                }

                if (item.sellIn < 6) {
                    incrementQltyIfLessThanMaxQlty(item)
                }
                item.sellIn = item.sellIn - 1

                if item.sellIn < 0 {
                    item.quality = item.quality - item.quality
                }
                continue
            }
            
            decrementQltyIfGreaterThanMinQlty(item)
            
            item.sellIn = item.sellIn - 1
            
            if (item.sellIn < 0) {
                decrementQltyIfGreaterThanMinQlty(item)
            }
        }
    }
}
