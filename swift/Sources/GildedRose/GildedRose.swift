
public class GildedRose {
    var items: [Item]
    private let specialItemStrategies: [SpecialItemStrategy]
    private let standardItemStrategy: ItemUpdatingStrategy
    
    init(items:[Item],
         specialItemStrategies: [SpecialItemStrategy],
         standardItemStrategy: ItemUpdatingStrategy) {
        self.items = items
        self.specialItemStrategies = specialItemStrategies
        self.standardItemStrategy = standardItemStrategy
    }
    
    public convenience init(items: [Item]) {
        self.init(items: items,
                  specialItemStrategies: [AltBaseStategy(handler: AgedBrieQualityUpdater()),
                                   SulfrasStrategy(),
                                   BackstagePassStrategy(),
                                   AltBaseStategy(handler: ConjuredItemQualityUpdater())
                  ],
                  standardItemStrategy: StandardItemStrategy())
    }
    
    
    public func updateQuality() {
        for item in items {
            /*
             1) Too much nested if statement ✅
             2) hard to understand and scattered logic
             3) needs methods to do the operations ✅
             4) item can be moved to a constant ✅
             5) magic numbers with no explanation ✅
             6) repeatitive conditions ✅
             7) literals in the code ✅
             8) literals are way to specified than the business rules ✅
             */
            
            if let strategy = specialItemStrategies.first(where: { strategy in
                strategy.canHandle(item: item)
            }) {
                strategy.updateItem(item: item)
            } else {
                standardItemStrategy.updateItem(item: item)
            }
        }
    }
}

protocol ItemUpdatingStrategy {
    func updateItem(item: Item)
}

protocol SpecialItemStrategy: ItemUpdatingStrategy {
    func canHandle(item: Item) -> Bool
}

class AgedBrieQualityUpdater: ConditionalQualityUpdater {
    func canHandle(item: Item) -> Bool {
        item.name == "Aged Brie"
    }

    func updateQuality(item: Item) {
        incrementQltyIfLessThanMaxQlty(item)
    }

    func updateExpiredItem(_ item: Item) {
        incrementQltyIfLessThanMaxQlty(item)
    }
}

class SulfrasStrategy: SpecialItemStrategy {
    func updateItem(item: Item) { }
    
    func canHandle(item: Item) -> Bool {
        item.name == "Sulfuras, Hand of Ragnaros"
    }
}

class StandardItemStrategy: BaseStrategy {
    override func updateQuality(item: Item) {
        decrementQltyIfGreaterThanMinQlty(item)
    }
    
    override func updateExpiredItem(_ item: Item) {
        decrementQltyIfGreaterThanMinQlty(item)
    }
}

class BackstagePassStrategy: BaseStrategy, SpecialItemStrategy {
    override func updateQuality(item: Item) {
        if item.sellIn < 6 {
            increaseQualityByIfLessThanMaxQlty(3, item: item)
        } else if item.sellIn < 11 {
            increaseQualityByIfLessThanMaxQlty(2, item: item)
        } else {
            incrementQltyIfLessThanMaxQlty(item)
        }
    }
    
    override func updateExpiredItem(_ item: Item) {
        item.quality = 0
    }
    
    func canHandle(item: Item) -> Bool {
        item.name == "Backstage passes to a TAFKAL80ETC concert"
    }
}

class ConjuredItemQualityUpdater: ConditionalQualityUpdater {
    func updateQuality(item: Item) {
        decrementQualityBy2(item)
    }
    
    func updateExpiredItem(_ item: Item) {
        decrementQualityBy2(item)
    }
    
    func canHandle(item: Item) -> Bool {
        item.name == "Conjured"
    }
    
    private func decrementQualityBy2(_ item: Item) {
        decrementQltyIfGreaterThanMinQlty(item)
        decrementQltyIfGreaterThanMinQlty(item)
    }
}

protocol QualityUpdater {
    func updateQuality(item: Item)
    func updateExpiredItem(_ item: Item)
    
    func decrementSellIn(_ item: Item)
    func isExpired(_ item: Item) -> Bool
}

extension QualityUpdater {
    var minQuality: Int { 0 }
    var maxQuality: Int { 50 }
    
    func incrementQltyIfLessThanMaxQlty(_ item: Item) {
        increaseQualityByIfLessThanMaxQlty(1, item: item)
    }
    
    func increaseQualityByIfLessThanMaxQlty(_ amount: Int, item: Item) {
        if (item.quality < maxQuality) {
            item.quality = item.quality + amount
        }
    }
    
    func decrementQltyIfGreaterThanMinQlty(_ item: Item) {
        if (item.quality > minQuality) {
            item.quality = item.quality - 1
        }
    }
    
    func decrementSellIn(_ item: Item) {
        item.sellIn = item.sellIn - 1
    }
    
    func isExpired(_ item: Item) -> Bool {
        return item.sellIn < 0
    }
}

protocol ConditionalQualityUpdater: QualityUpdater {
    func canHandle(item: Item) -> Bool
}

class AltBaseStategy<Handler: QualityUpdater>: ItemUpdatingStrategy {
    let handler: Handler
    
    init(handler: Handler) {
        self.handler = handler
    }
    
    func updateItem(item: Item) {
        handler.updateQuality(item: item)
        handler.decrementSellIn(item)
        if handler.isExpired(item) {
            handler.updateExpiredItem(item)
        }
    }
}

extension AltBaseStategy: SpecialItemStrategy where Handler: ConditionalQualityUpdater {
    func canHandle(item: Item) -> Bool {
        handler.canHandle(item: item)
    }
}

class BaseStrategy: ItemUpdatingStrategy {
    let minQuality: Int = 0
    let maxQuality: Int = 50
    
    func updateItem(item: Item) {
        updateQuality(item: item)
        decrementSellIn(item)
        if isExpired(item) {
            updateExpiredItem(item)
        }
    }

    func updateQuality(item: Item) {

    }
    
    func updateExpiredItem(_ item: Item) {
        
    }
    
    func incrementQltyIfLessThanMaxQlty(_ item: Item) {
        increaseQualityByIfLessThanMaxQlty(1, item: item)
    }
    
    func increaseQualityByIfLessThanMaxQlty(_ amount: Int, item: Item) {
        if (item.quality < maxQuality) {
            item.quality = item.quality + amount
        }
    }
    
    func decrementQltyIfGreaterThanMinQlty(_ item: Item) {
        if (item.quality > minQuality) {
            item.quality = item.quality - 1
        }
    }
    
    func decrementSellIn(_ item: Item) {
        item.sellIn = item.sellIn - 1
    }
    
    func isExpired(_ item: Item) -> Bool {
        return item.sellIn < 0
    }
}
