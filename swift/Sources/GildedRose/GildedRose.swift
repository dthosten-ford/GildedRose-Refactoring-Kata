
public class GildedRose {
    var items:[Item]
    var baseStrategy = BaseItemStrategy()
    
    public init(items:[Item]) {
        self.items = items
    }
    
    private enum ItemType {
        case normalItem
        case agedBrie
        case sulfras
        case backstagePass
        
        static func typeFor(itemName: String) -> ItemType {
            switch itemName {
            case "Sulfuras, Hand of Ragnaros":
                return .sulfras
            case "Aged Brie":
                return .agedBrie
            case "Backstage passes to a TAFKAL80ETC concert":
                return .backstagePass
            default:
                return .normalItem
            }
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
            let itemType = ItemType.typeFor(itemName: item.name)
            switch itemType {
            case .normalItem:
                StandardItemStrategy().updateItem(item: item)
            case .agedBrie:
                AgedBrieUpdateStrategy().updateItem(item: item)
            case .sulfras:
                SulfrasStrategy().updateItem(item: item)
            case .backstagePass:
                BackstagePassStrategy().updateItem(item: item)
            }
        }
    }
}

protocol ItemUpdatingStrategy {
    func updateItem(item: Item)
}

class BaseItemStrategy {
    let minQuality = 0
    let maxQuality = 50
    
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
    
    fileprivate func decrementSellIn(_ item: Item) {
        item.sellIn = item.sellIn - 1
    }
    
    fileprivate func isExpired(_ item: Item) -> Bool {
        return item.sellIn < 0
    }
}

class AgedBrieUpdateStrategy: BaseItemStrategy, ItemUpdatingStrategy {
    
    func updateItem(item: Item) {
        incrementQltyIfLessThanMaxQlty(item)
        decrementSellIn(item)
        
        if isExpired(item) {
            incrementQltyIfLessThanMaxQlty(item)
        }
    }
    
}


class SulfrasStrategy: ItemUpdatingStrategy {
    func updateItem(item: Item) { }
}

class StandardItemStrategy: BaseItemStrategy, ItemUpdatingStrategy {
    func updateItem(item: Item) {
        decrementQltyIfGreaterThanMinQlty(item)
        
        decrementSellIn(item)
        
        if isExpired(item) {
            decrementQltyIfGreaterThanMinQlty(item)
        }
    }
}

class BackstagePassStrategy: BaseItemStrategy, ItemUpdatingStrategy {
    func updateItem(item: Item) {
        if item.sellIn < 6 {
            increaseQualityByIfLessThanMaxQlty(3, item: item)
        } else if item.sellIn < 11 {
            increaseQualityByIfLessThanMaxQlty(2, item: item)
        } else {
            incrementQltyIfLessThanMaxQlty(item)
        }
        decrementSellIn(item)

        if isExpired(item) {
            item.quality = item.quality - item.quality
        }
    }
}
