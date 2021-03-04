package com.gildedrose

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test

internal class GildedRoseTest {

    private fun getGildedRoseWithItems(name: String, sellIn: Int, quality: Int): GildedRose {
        val items = arrayOf(Item(name, sellIn, quality))
        return GildedRose(items)
    }

    @Test
    fun testItemQualityIsNeverNegative() {
        val app = getGildedRoseWithItems("foo", 0, 0)
        app.updateQuality()
        assertTrue(app.items[0].quality >= 0)
    }

    @Test
    fun testItemQualityIsNeverMoreThan50() {
        val app = getGildedRoseWithItems("Aged Brie", 0, 50)
        app.updateQuality()
        assertEquals(50, app.items[0].quality)
    }

    @Test
    fun testAgedBrieShouldIncreaseQualityBy2() {
        val app = getGildedRoseWithItems("Aged Brie", 0, 38)
        app.updateQuality()
        assertEquals(40, app.items[0].quality)
    }

    @Test
    fun testSystemLowersBothValuesForEveryItemAtTheEndOfEachDay() {
        val app = getGildedRoseWithItems("ASDF", 0, 49)
        app.updateQuality()
        assertEquals(47, app.items[0].quality)
        assertEquals(-1, app.items[0].sellIn)
    }

    @Test
    fun testItemQualityIncreasesTo50WhileSellInLessThan6() {
        val app =  getGildedRoseWithItems("Backstage passes to a TAFKAL80ETC concert", 5, 45)
        app.updateQuality()
        assertEquals(48, app.items[0].quality)
    }

    @Test
    fun testItemQualityIncreasesTo50WhileSellInGreaterThan6ButLessThan11() {
        val app =  getGildedRoseWithItems("Backstage passes to a TAFKAL80ETC concert", 7, 45)
        app.updateQuality()
        assertEquals(47, app.items[0].quality)
    }

    @Test
    fun testItemQualityBecomesZeroAfterConcertIfItIsBackstage(){
        val app = getGildedRoseWithItems("Backstage passes to a TAFKAL80ETC concert", 0, 45)
        app.updateQuality()
        assertEquals(0, app.items[0].quality)
    }

    @Test
    fun testSulfurasWithItems() {
        val app = getGildedRoseWithItems("Sulfuras, Hand of Ragnaros", 0, 0)
        app.updateQuality()
        assertEquals(0, app.items[0].quality)
        assertEquals(0, app.items[0].sellIn)
    }
}


