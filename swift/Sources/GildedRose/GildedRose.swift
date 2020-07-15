public class GildedRose {
    var items:[Item]
    
    public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        for i in 0..<items.count {
            //If newCodeExistsForTheItem
            //  perform the new rules (maybe call an item-specific class i.e. AgedB
            //todo: create local variable for the current item instead
            if (items[i].name == "Aged Brie"){
                let rule = agedBrieRules()
                items[i] = rule.doStuff(items[i])
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


public class agedBrieRules {
    func doStuff(_ item: Item) -> Item{
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
