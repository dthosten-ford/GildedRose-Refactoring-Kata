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
    private let backstage = "Backstage passes to a TAFKAL80ETC concert"

    func strategyForItem(_ item: Item) -> ItemUpdater {
        if (item.name == sulfuras) {
            return DoNothingStrategy()
        }
        if item.name == agedBrie {
            return AgedBrieStrategy()
        }
        if item.name == backstage {
            return BackstageStrategy()
        }
        return RegularItemUpdater()
    }
}

class RegularItemUpdater: ItemUpdater {
    pass item in Init
    private let mutator = IncrementDecrementHolder()
    
    func updateItem(_ item: Item) {
        mutator.decrementQualityBy1(item)
        
        mutator.decrementSellIn(item)
        
        if mutator.isExpired(item) {
            mutator.decrementQualityBy1(item)
        }
    }
}

class DoNothingStrategy: ItemUpdater {
    func updateItem(_ item: Item) { }
}

class AgedBrieStrategy: ItemUpdater {
    private let mutator = IncrementDecrementHolder()
    
    func updateItem(_ item: Item) {
        mutator.incrementQualityBy1(item)
        mutator.decrementSellIn(item)
        if mutator.isExpired(item) {
            mutator.incrementQualityBy1(item)
        }
    }
}

class BackstageStrategy: ItemUpdater {
    let incDecMutator = IncrementDecrementHolder()
    
    func updateItem(_ item: Item) {

        incDecMutator.incrementQualityBy1(item)
        if (item.sellIn < 11) {
            incDecMutator.incrementQualityBy1(item)
        }

        if (item.sellIn < 6) {
            incDecMutator.incrementQualityBy1(item)
        }
        
        incDecMutator.decrementSellIn(item)
        
        if incDecMutator.isExpired(item) {
            item.quality = item.quality - item.quality
        }
    }
}

class IncrementDecrementHolder {
    private let maxItemQuality = 50
    private let minItemQuality = 0

    func incrementQualityBy1(_ item: Item) {
        if (item.quality < maxItemQuality) {
            item.quality = item.quality + 1
        }
    }

    func decrementQualityBy1(_ item: Item) {
        if (item.quality > minItemQuality) {
            item.quality = item.quality - 1
        }
    }
    
    func isExpired(_ item: Item) -> Bool {
        return item.sellIn < 0
    }
    
    func decrementSellIn(_ item: Item) {
        item.sellIn -= 1
    }
}
