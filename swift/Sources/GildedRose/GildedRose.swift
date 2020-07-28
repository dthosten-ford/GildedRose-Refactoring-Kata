public class GildedRose {
    var items:[Item]
    var strategyMap:[String : ProductQualityStrategy] = [:]
    
    public init(items:[Item]) {
        self.items = items
        createStrategy()
    }
    
    private func createStrategy(){
        strategyMap["Aged Brie"] = agedBrieRules()
        strategyMap["Backstage passes to a TAFKAL80ETC concert"] = BackstagePassRules()
    }
    
    public func updateQuality() {
        for i in 0..<items.count {
            //If newCodeExistsForTheItem
            //  perform the new rules (maybe call an item-specific class i.e. AgedB
            //todo: create local variable for the current item instead
            if let rule = strategyMap[items[i].name] {
                items[i] = rule.update(items[i])
            }
            else{
                //do the old rules below
                crappyLegacyRules(item: items, index: i)
            }
        }
        
}
    public func crappyLegacyRules(item: [Item], index i: Int){
        if (items[i].name != "Aged Brie" && items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                    if (items[i].quality > 0) {
                        if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                            items[i].quality = items[i].quality - 1
                        }
                    }
                } else {
                    if (items[i].quality < 50) {
                        items[i].quality = items[i].quality + 1
                        
                        if (items[i].name == "Backstage passes to a TAFKAL80ETC concert") {
                            if (items[i].sellIn < 11) {
                                if (items[i].quality < 50) {
                                    items[i].quality = items[i].quality + 1
                                }
                            }
                            
                            if (items[i].sellIn < 6) {
                                if (items[i].quality < 50) {
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
                            if (items[i].quality > 0) {
                                if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                                    items[i].quality = items[i].quality - 1
                                }
                            }
                        } else {
                            items[i].quality = items[i].quality - items[i].quality
                        }
                    } else {
                        if (items[i].quality < 50) {
                            items[i].quality = items[i].quality + 1
                        }
                    }
                }
            }
        

}

protocol ProductQualityStrategy {
    func update(_ item: Item) -> Item
}

public class agedBrieRules : ProductQualityStrategy {
    func update(_ item: Item) -> Item{
        //TODO: see if we can clean this up more.  perhaps use MIN()
        item.quality += 1
        if item.sellIn < 0 {
            item.quality += 1
        }
        if item.quality > 50 {
            item.quality = 50
        }
        return item
    }
}

class BackstagePassRules: ProductQualityStrategy {
    func update(_ item: Item) -> Item {
        item.quality += 1
        
        if item.sellIn <= 10 {
            item.quality += 1
        }
        if item.sellIn <= 5 {
            item.quality += 1
        }
        
        if item.sellIn <= 0 {
            item.quality = 0
        }
        
        item.quality = min(item.quality, 50)
        return item
    }
}
