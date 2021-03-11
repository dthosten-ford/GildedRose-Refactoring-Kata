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

    val itemStrategy: ItemStrategy = ItemStrategy()
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
            itemStrategy.decreaseSellInByOne(item)
            when (item.name) {
                AGED_BRIE -> BrieStrategy().updateQuality(item)
                BACKSTAGE_PASSES -> BackstageStrategy().updateQuality(item)
                else -> itemStrategy.updateQuality(item)
            }
        }
    }

    inner class BackstageStrategy: ItemStrategy() {

        override fun updateQuality(item: Item) {
            handleBackstageDiscountDays(item)
            handleComingSoonDaysQuality(item)
            itemStrategy.increaseQualityByOne(item)
            if (itemStrategy.eventHasPassed(item)) {
                itemStrategy.resetItemQuality(item)
            }
        }

        fun handleBackstageDiscountDays(item: Item) {
            if (item.sellIn < BACKSTAGE_DISCOUNT_DAYS) {
                itemStrategy.increaseQualityByOne(item)
            }
        }

        fun handleComingSoonDaysQuality(item: Item) {
            if (item.sellIn < BACKSTAGE_COMING_SOON_DAYS_EVENTS) {
                itemStrategy.increaseQualityByOne(item)
            }
        }
    }

    inner class BrieStrategy: ItemStrategy() {

        override fun updateQuality(item: Item) {
            itemStrategy.increaseQualityByOne(item)
            if (itemStrategy.eventHasPassed(item)) {
                itemStrategy.increaseQualityByOne(item)
            }
        }
    }

    open inner class ItemStrategy {

        open fun updateQuality(item: Item) {
            if (item.quality > MINIMUM_QUALITY) {
                itemStrategy.decreaseItemQuality(item)
                itemStrategy.minimumSellInDecreaseItemQuality(item)
            }
        }

        fun decreaseItemQuality(item: Item) {
            item.quality = item.quality - 1
        }

        fun minimumSellInDecreaseItemQuality(item: Item) {
            if (item.sellIn < MINIMUM_SELL_IN) {
                itemStrategy.decreaseItemQuality(item)
            }
        }

        fun decreaseSellInByOne(item: Item) {
            item.sellIn = item.sellIn - 1
        }

        fun resetItemQuality(item: Item) {
            item.quality = item.quality - item.quality
        }

        fun increaseQualityByOne(item: Item) {
            if (item.quality < MAX_QUALITY) {
                item.quality = item.quality + 1
            }
        }

        fun eventHasPassed(item: Item) = item.sellIn < MINIMUM_QUALITY
    }
}



