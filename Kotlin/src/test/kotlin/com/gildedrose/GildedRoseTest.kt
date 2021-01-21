package com.gildedrose

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test

internal class GildedRoseTest {

    @Test
    fun testItemQualityIsNeverNegative() {
        val items = arrayOf<Item>(Item("foo", 0, 0))
        val app = GildedRose(items)

        app.updateQuality()

        assertTrue(items[0].quality >= 0)
    }

    @Test
    fun testItemQualityIsNeverMoreThan50() {
        val items = arrayOf(Item("Aged Brie", 0, 50))
        val app = GildedRose(items)

        app.updateQuality()

        assertEquals(50, items[0].quality)
    }

    @Test
    fun testAgedBrieShouldIncreaseQualityBy2() {
        val items = arrayOf(Item("Aged Brie", 0, 48))
        val app = GildedRose(items)

        app.updateQuality()
        assertEquals(50, items[0].quality)
    }

    @Test
    fun testSystemLowersBothValuesForEveryItemAtTheEndOfEachDay() {
        val items = arrayOf(Item("ASDF", 0, 49))
        val app = GildedRose(items)

        app.updateQuality()
        assertEquals(47, items[0].quality)
        assertEquals(-1, items[0].sellIn)
    }
}


