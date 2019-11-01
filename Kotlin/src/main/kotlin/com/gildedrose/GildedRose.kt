package com.gildedrose

class GildedRose(var items: Array<Item>) {

    fun updateQuality() {
        for (i in items.indices) {
            when (items[i].name) {
                    "Backstage passes to a TAFKAL80ETC concert" ->updateBackStageQuality()
            }

            if (!items[i].name.equals("Aged Brie") && !items[i].name.equals("Backstage passes to a TAFKAL80ETC concert")) {
                if (items[i].quality > 0) {
                    if (!items[i].name.equals("Sulfuras, Hand of Ragnaros")) {
                        items[i].quality = items[i].quality - 1
                    }
                }
            } else {
                if (items[i].quality < 50) {
                    items[i].quality = items[i].quality + 1

                    if (items[i].name.equals("Backstage passes to a TAFKAL80ETC concert")) {
                        if (items[i].sellIn < 11 && items[i].quality < 50) {
                                items[i].quality = items[i].quality + 1
                        }
                      // combining mutliple nested if statement or conditions.
                        if (items[i].sellIn < 6 && items[i].quality < 50) {
                           // if (items[i].quality < 50) {
                                items[i].quality = items[i].quality + 1
                           // }
                        }
                    }
                }
            }

            if (!items[i].name.equals("Sulfuras, Hand of Ragnaros")) {
                items[i].sellIn = items[i].sellIn - 1
            }

            if (items[i].sellIn < 0) {
                if (!items[i].name.equals("Aged Brie")) {
                    if (!items[i].name.equals("Backstage passes to a TAFKAL80ETC concert")) {
                        if (items[i].quality > 0) {
                            if (!items[i].name.equals("Sulfuras, Hand of Ragnaros")) {
                                items[i].quality = items[i].quality - 1
                            }
                        }
                        //Make items[i].quality = 0
                    } else { // BSP quality is 0
                        items[i].quality = items[i].quality - items[i].quality
                    }
                } else { // Brie should be incremented by 1
                    if (items[i].quality < 50) {
                        items[i].quality = items[i].quality + 1
                    }
                }
            }
        }
    }

    private fun updateBackStageQuality() {

    }

}

