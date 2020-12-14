package com.gildedrose

import org.junit.Assert.*
import org.junit.Test

class GildedRoseTest {

    @Test
    fun foo() {
        val items = arrayOf<Item>(Item("foo", 0, 0))
        val app = GildedRose(items)
        assertEquals("foo", app.items[0].name)
    }

    @Test
    fun qualityDegradesByOneDaily() {
        val app = setupApp(sellIn = 1, quality = 10)
        assertEquals(9, app.items[0].quality)
    }

    @Test
    fun qualityDegradesTwiceDailyAfterSellin() {
        val app = setupApp(sellIn = -1, quality = 10)
        assertEquals(8, app.items[0].quality)
    }

    @Test
    fun qualityDoesNotFallBelowZero() {
        val app = setupApp(quality = 0)
        assertEquals(0, app.items[0].quality)
    }

    companion object {
        private const val defaultQuality = 42
    }

    @Test
    fun nameIsEqualtoAgedBrieIfQualityIsLessThan50IncrementCurrentQuality(){
        setupApp2(name = "Aged Brie").assertQualityDelta(1)
    }

    private fun Pair<Int,GildedRose>.assertQualityDelta(delta: Int = 1) {
        assertEquals(this.first + delta, this.second.items[0].quality)
    }

    @Test
    fun nameIsEqualtoAgedBrieIfQualityIs50DoesNotIncrementCurrentQuality(){
        val app = setupApp(name = "Aged Brie", quality = 50)
        app.updateQuality()
        assertEquals(50, app.items[0].quality)
    }

    @Test
    fun qualityIs50DoesnotIncrementCurrentQuality() {
        val app = setupApp(quality = 51)
        assertEquals(50, app.items[0].quality)
    }

    @Test
    fun nameIsSulfurasDoesNotDecrementQuality() {
        val app = setupApp(name = "Sulfuras, Hand of Ragnaros" , quality = 22)
        assertEquals(22, app.items[0].quality)
    }

    private fun setupApp(name: String = "foo", sellIn: Int = 1, quality: Int = 0): GildedRose {
        val items = arrayOf<Item>(Item(name, sellIn, quality))
        val app = GildedRose(items).also {
            it.updateQuality()
        }
        return app
    }

    private fun setupApp2(name: String = "foo", sellIn: Int = 1, quality: Int = 0) = run {
        val items = arrayOf<Item>(Item(name, sellIn, quality))
        val app = GildedRose(items).also {
            it.updateQuality()
        }
        quality to app
    }
}


