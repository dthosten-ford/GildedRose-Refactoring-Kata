
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
                baseStrategy.decrementQltyIfGreaterThanMinQlty(item)
                
                baseStrategy.decrementSellIn(item)
                
                if baseStrategy.isExpired(item) {
                    baseStrategy.decrementQltyIfGreaterThanMinQlty(item)
                }
            case .agedBrie:
                AgedBrieUpdateStrategy().updateItem(item: item)
            case .sulfras:
                SulfrasStrategy().updateItem(item: item)
            case .backstagePass:
                baseStrategy.incrementQltyIfLessThanMaxQlty(item)
                if (item.sellIn < 11) {
                    baseStrategy.incrementQltyIfLessThanMaxQlty(item)
                }
                
                if (item.sellIn < 6) {
                    baseStrategy.incrementQltyIfLessThanMaxQlty(item)
                }
                baseStrategy.decrementSellIn(item)
                
                if baseStrategy.isExpired(item) {
                    item.quality = item.quality - item.quality
                }
            }
        }
    }
}

protocol ItemUpdatingStrategy {
    func updateItem(item: Item)
}

class BaseItemStrategy: ItemUpdatingStrategy {
    let minQuality = 0
    let maxQuality = 50
    
    func updateItem(item: Item) {}
    
    func incrementQltyIfLessThanMaxQlty(_ item: Item) {
        if (item.quality < maxQuality) {
            item.quality = item.quality + 1
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

class AgedBrieUpdateStrategy: BaseItemStrategy {
    
    override func updateItem(item: Item) {
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
