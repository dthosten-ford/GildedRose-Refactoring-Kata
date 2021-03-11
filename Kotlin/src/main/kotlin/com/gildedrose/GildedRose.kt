package com.gildedrose

private const val MAX_QUALITY = 50
private const val MINIMUM_QUALITY = 0
private const val BACKSTAGE_DISCOUNT_DAYS = 11
private const val BACKSTAGE_COMING_SOON_DAYS_EVENTS = 6
private const val AGED_BRIE = "Aged Brie"
private const val BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
private const val SULFURAS = "Sulfuras, Hand of Ragnaros"
private const val MINIMUM_SELL_IN = 0


class GildedRose(var items: Array<Item>) {

    /* What sux about this code?
        * - 2 many IF's -> ???
        *   - create descriptive methods for code
        *   - Duplicate Logic -> Make DRY (Don't Repeat Yourself)
        * - Distributed Logic -> Consolidate by Name
        * - consider simplification/abstraction with Protocol/Interface
        * */

    fun updateQuality() {
        for (item in items) {
            if (item.name == SULFURAS) {    //TODO
                return
            }
            decreaseSellInByOne(item)
            when (item.name) {
                AGED_BRIE -> handlesAgedBrieQuality(item)
                BACKSTAGE_PASSES -> handlesBackstageQuality(item)
                else -> handlesDefaultQuality(item)
            }
        }
    }

    private fun handlesAgedBrieQuality(item: Item) {
        increaseQualityByOne(item)
        if (eventHasPassed(item)) {
            increaseQualityByOne(item)
        }
    }

    private fun handlesBackstageQuality(item: Item) {
        handleBackstageDiscountDays(item)
        handleComingSoonDaysQuality(item)
        increaseQualityByOne(item)
        if (eventHasPassed(item)) {
            resetItemQuality(item)
        }
    }

    private fun handleComingSoonDaysQuality(item: Item) {
        if (item.sellIn < BACKSTAGE_COMING_SOON_DAYS_EVENTS) {
            increaseQualityByOne(item)
        }
    }

    private fun handleBackstageDiscountDays(item: Item) {
        if (item.sellIn < BACKSTAGE_DISCOUNT_DAYS) {  //TODO: multiple if's
            increaseQualityByOne(item)
        }
    }

    private fun eventHasPassed(item: Item) = item.sellIn < MINIMUM_QUALITY

    private fun handlesDefaultQuality(item: Item) {
        if (item.quality > MINIMUM_QUALITY) {
            decreaseItemQuality(item)
            minimumSellInDecreaseItemQuality(item)
        }
    }

    private fun minimumSellInDecreaseItemQuality(item: Item) {
        if (item.sellIn < MINIMUM_SELL_IN) {
            decreaseItemQuality(item)
        }
    }

    private fun decreaseSellInByOne(item: Item) {
        item.sellIn = item.sellIn - 1
    }

    private fun resetItemQuality(item: Item) {
        item.quality = item.quality - item.quality
    }

    private fun increaseQualityByOne(item: Item) {
        if (item.quality < MAX_QUALITY) {
            item.quality = item.quality + 1
        }
    }

    private fun decreaseItemQuality(item: Item) {
        item.quality = item.quality - 1
    }

}

