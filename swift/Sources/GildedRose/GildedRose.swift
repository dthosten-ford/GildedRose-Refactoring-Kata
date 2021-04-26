public class GildedRose {
    var items:[Item]

    private let startegyProvider: ItemStrategyProvider = StrategyProvider()
    
    public init(items:[Item]) {
        self.items = items
    }
    
    // TODO:
    // ✅ Getting rid of magic numbers
    // * Remove repetitive if conditions
    // ✅ Literal strings
    // ✅ Extract repetitive functionality into methods
    // ✅ Rename indexer form array of items
    // *

    public func updateQuality() {
        for item in items {
            startegyProvider.strategyForItem(item).updateItem(item)
        }
    }
}

protocol ItemUpdater {
    func updateItem(_ item: Item)
}

protocol ItemStrategyProvider {
    func strategyForItem(_ item: Item) -> ItemUpdater
}

class StrategyProvider: ItemStrategyProvider {
    private let sulfuras = "Sulfuras, Hand of Ragnaros"
    private let agedBrie = "Aged Brie"

    func strategyForItem(_ item: Item) -> ItemUpdater {
        if (item.name == sulfuras) {
            return DoNothingStrategy()
        }
        if item.name == agedBrie {
           return AgedBrieStrategy()
        }
        return LegacyItemUpdater()
    }
}

class LegacyItemUpdater: ItemUpdater {
    private let maxItemQuality = 50
    private let minItemQuality = 0
    private let agedBrie = "Aged Brie"
    private let backstage = "Backstage passes to a TAFKAL80ETC concert"
    
    func updateItem(_ item: Item) {
        if item.name == agedBrie {
            incrementQualityBy1(item)
        } else if (item.name == backstage) {
            incrementQualityBy1(item)

            if (item.sellIn < 11) {
                incrementQualityBy1(item)
            }

            if (item.sellIn < 6) {
                incrementQualityBy1(item)
            }
        } else {
            decrementQualityBy1(item)
        }
        
        item.sellIn = item.sellIn - 1
        
        if isExpired(item) {
            if (item.name == agedBrie) {
                incrementQualityBy1(item)
            } else if (item.name == backstage) {
                item.quality = item.quality - item.quality
            } else {
                decrementQualityBy1(item)
            }
        }
    }
    
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
    
    fileprivate func isExpired(_ item: Item) -> Bool {
        return item.sellIn < 0
    }
}

class DoNothingStrategy: ItemUpdater {
    func updateItem(_ item: Item) { }
}

cleanup the duplicate code

class AgedBrieStrategy: ItemUpdater {
    private let maxItemQuality = 50
    private let minItemQuality = 0
    
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
    
    private func isExpired(_ item: Item) -> Bool {
        return item.sellIn < 0
    }
    
    func updateItem(_ item: Item) {
        incrementQualityBy1(item)
        item.sellIn = item.sellIn - 1
        if isExpired(item) {
            incrementQualityBy1(item)
        }
    }
}
