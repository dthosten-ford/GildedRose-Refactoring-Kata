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
            let strategy: ItemUpdater = startegyProvider.strategyForItem(item)
            strategy.updateQuality(item)
            strategy.updateSellin(item)
            if isExpired(item) {
                strategy.updateExpiredQuality(item)
            }
        }
    }
    
    func isExpired(_ item: Item) -> Bool {
        return item.sellIn < 0
    }
}

protocol ItemUpdater {
    func updateQuality(_ item: Item)
    func updateSellin(_ item: Item)
    func updateExpiredQuality(_ item: Item)
}

extension ItemUpdater {
    func updateSellin(_ item: Item) {
        item.sellIn -= 1
    }
}

protocol ItemStrategyProvider {
    func strategyForItem(_ item: Item) -> ItemUpdater
}

class StrategyProvider: ItemStrategyProvider {
    private let sulfuras = "Sulfuras, Hand of Ragnaros"
    private let agedBrie = "Aged Brie"
    private let backstage = "Backstage passes to a TAFKAL80ETC concert"
    private let mutator = IncrementDecrementHolder()

    func strategyForItem(_ item: Item) -> ItemUpdater {
        if (item.name == sulfuras) {
            return DoNothingStrategy()
        }
        if item.name == agedBrie {
            return AgedBrieStrategy(mutator: mutator)
        }
        if item.name == backstage {
            return BackstageStrategy(mutator: mutator)
        }
        return RegularItemUpdater(mutator: mutator)
    }
}

class RegularItemUpdater: ItemUpdater {
    private let mutator: IncrementDecrementHolder
    
    init(mutator: IncrementDecrementHolder) {
        self.mutator = mutator
    }
    
    func updateQuality(_ item: Item) {
        mutator.decrementQualityBy1(item)
    }
    
    func updateExpiredQuality(_ item: Item) {
        mutator.decrementQualityBy1(item)
    }
}

class DoNothingStrategy: ItemUpdater {
    func updateQuality(_ item: Item) { }
    func updateExpiredQuality(_ item: Item) {}
    func updateSellin(_ item: Item) { }
}

class AgedBrieStrategy: ItemUpdater {
    private let mutator: IncrementDecrementHolder

    init(mutator: IncrementDecrementHolder) {
        self.mutator = mutator
    }
    
    func updateExpiredQuality(_ item: Item) {
        mutator.incrementQualityBy1(item)
    }
    
    func updateQuality(_ item: Item) {
        mutator.incrementQualityBy1(item)
    }
}

class BackstageStrategy: ItemUpdater {
    private let margin = 6
    private let mutator: IncrementDecrementHolder

    init(mutator: IncrementDecrementHolder) {
        self.mutator = mutator
    }
    
    func updateExpiredQuality(_ item: Item) {
        item.quality = item.quality - item.quality
    }
    
    func updateQuality(_ item: Item) {
        let qualityChange: Int
        switch item.sellIn {
        case ..<margin:
            qualityChange = 3
        case ..<11:
            qualityChange = 2
        default:
            qualityChange = 1
        }
        increaseQuality(by: qualityChange, item: item)
    }
    
    private func increaseQuality(by amount: Int, item: Item) {
        (0..<amount).forEach { _ in mutator.incrementQualityBy1(item) }
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
}
