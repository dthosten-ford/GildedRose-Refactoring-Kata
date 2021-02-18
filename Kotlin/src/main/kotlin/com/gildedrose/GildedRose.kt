package com.gildedrose

private const val MAX_QUALITY = 50
private const val MINIMUM_QUALITY = 0
private const val BACKSTAGE_DOUBLE_QUALITY_DAYS = 11 //TODO: Think new name
private const val BACKSTAGE_QUALITY_INCREASE_BY_3_DAYS = 6 //TODO: Think new name
private const val AGED_BRIE = "Aged Brie"
private const val BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
private const val SULFURAS = "Sulfuras, Hand of Ragnaros"


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
        for (item in items) {
            if (item.name == SULFURAS) {
                return
            }
            item.sellIn = item.sellIn - 1
            when (item.name) {
                AGED_BRIE -> {
                    increaseQualityByOne(item)
                }
                BACKSTAGE_PASSES -> {
                    if (item.sellIn < BACKSTAGE_DOUBLE_QUALITY_DAYS) {
                        increaseQualityByOne(item)
                    }
                    if (item.sellIn < BACKSTAGE_QUALITY_INCREASE_BY_3_DAYS) {
                        increaseQualityByOne(item)
                    }
                    increaseQualityByOne(item)
                }
                else -> {
                    if (item.quality > MINIMUM_QUALITY) {
                        decreaseItemQualityIfNotSulfuras(item)
                    }
                }
            }

            if (item.sellIn < MINIMUM_QUALITY) {
                if (item.name == AGED_BRIE) {
                    increaseQualityByOne(item)
                } else if (item.name == BACKSTAGE_PASSES) {
                    item.quality = item.quality - item.quality
                } else {
                    if (item.quality > MINIMUM_QUALITY) {
                        item.quality = item.quality - 1
                    }
                }
            }
        }
    }

    private fun increaseQualityByOne(item: Item) {
        if (item.quality < MAX_QUALITY) {
            item.quality = item.quality + 1
        }
    }

    private fun decreaseItemQualityIfNotSulfuras(item: Item) {
        item.quality = item.quality - 1
    }

}

