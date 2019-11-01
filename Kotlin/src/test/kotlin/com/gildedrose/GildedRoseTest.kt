package com.gildedrose

import org.junit.Assert.assertEquals
import org.junit.Test

class GildedRoseTest {

    // the item is a backstage ticket and there's more than 10 days until
    @Test
    fun isBackStage_withQualitySignificantlyLessThanFiftyAndSellMoreThanTen_incrementQualityByOne() {
        val items = arrayOf(Item("Backstage passes to a TAFKAL80ETC concert", 15, 30))
        val app = GildedRose(items)
        app.updateQuality()

        assertEquals(31, app.items[0].quality)
    }

    //quality is already at max which is 50.
    @Test
    fun withQualityEqualsFifty_incrementQualityByZero() {
        val items = arrayOf(Item("Backstage passes to a TAFKAL80ETC concert", 10, 50))
        val app = GildedRose(items)
        app.updateQuality()

        assertEquals(50, app.items[0].quality)
    }

    @Test
    fun isBackStage_withQualityLessThanFortyNineAndSellInLessThanEleven_incrementQualityByTwo() {
        val items = arrayOf(Item("Backstage passes to a TAFKAL80ETC concert", 10, 48))
        val app = GildedRose(items)
        app.updateQuality()

        assertEquals(50, app.items[0].quality)
    }

    @Test
    fun isBackStage_withQualityLessThanFortyEightAndSellInLessThanSix_incrementQualityByThree() {
        val items = arrayOf(Item("Backstage passes to a TAFKAL80ETC concert", 3, 42))
        val app = GildedRose(items)
        app.updateQuality()

        assertEquals(45, app.items[0].quality)
    }


    @Test
    fun isBackStage_withListOfItems_incrementQualityByThree() {
        val items = arrayOf(Item("Backstage passes to a TAFKAL80ETC concert", 3, 49),
                Item("Backstage passes to a TAFKAL80ETC concert", 3, 48),
                Item("Backstage passes to a TAFKAL80ETC concert", 3, 46))
        val app = GildedRose(items)
        app.updateQuality()

        assertEquals(50, app.items[0].quality)
        assertEquals(50, app.items[1].quality)
        assertEquals(49, app.items[2].quality)
    }

    @Test
    fun isBackStage_withSellInZero_makeQualityAsZero() {
        val items = arrayOf(Item("Backstage passes to a TAFKAL80ETC concert", 0, 42))
        val app = GildedRose(items)
        app.updateQuality()

        assertEquals(0, app.items[0].quality)
    }
}


