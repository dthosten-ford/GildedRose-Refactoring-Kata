package com.gildedrose

private const val MAX_QUALITY = 50
private const val MINIMUM_QUALITY = 0
private const val BACKSTAGE_DOUBLE_QUALITY_DAYS = 11 //TODO: Think new name
private const val BACKSTAGE_QUALITY_INCREASE_BY_3_DAYS = 6 //TODO: Think new name

class GildedRose(var items: Array<Item>) {

    /* What sux about this code?
    * - Magic Numbers -> Create Constants
    * - String Literals -> move to variables
    * - remove item subscript - overly verboseification -> Refactor to simplify
    * - 2 many IF's -> ???
    *   - create descriptive methods for code
    *   - Duplicate Logic -> Make DRY (Don't Repeat Yourself)
    * - Distributed Logic -> Consolidate by Name
    * - consider simplification/abstraction with Protocol/Interface
    *
    * */
    fun updateQuality() {

        for (i in items.indices) {
            if (items[i].name != "Aged Brie" && items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                if (items[i].quality > MINIMUM_QUALITY) {
                    if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                        items[i].quality = items[i].quality - 1
                    }
                }
            } else {
                if (items[i].quality < MAX_QUALITY) {
                    items[i].quality = items[i].quality + 1

                    if (items[i].name == "Backstage passes to a TAFKAL80ETC concert") {
                        if (items[i].sellIn < BACKSTAGE_DOUBLE_QUALITY_DAYS) {
                            if (items[i].quality < MAX_QUALITY) {
                                items[i].quality = items[i].quality + 1
                            }
                        }

                        if (items[i].sellIn < BACKSTAGE_QUALITY_INCREASE_BY_3_DAYS) {
                            if (items[i].quality < MAX_QUALITY) {
                                items[i].quality = items[i].quality + 1
                            }
                        }
                    }
                }
            }

            if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                items[i].sellIn = items[i].sellIn - 1
            }

            if (items[i].sellIn < MINIMUM_QUALITY) {
                if (items[i].name != "Aged Brie") {
                    if (items[i].name != "Backstage passes to a TAFKAL80ETC concert") {
                        if (items[i].quality > MINIMUM_QUALITY) {
                            if (items[i].name != "Sulfuras, Hand of Ragnaros") {
                                items[i].quality = items[i].quality - 1
                            }
                        }
                    } else {
                        items[i].quality = items[i].quality - items[i].quality
                    }
                } else {
                    if (items[i].quality < MAX_QUALITY) {
                        items[i].quality = items[i].quality + 1
                    }
                }
            }
        }
    }

}

