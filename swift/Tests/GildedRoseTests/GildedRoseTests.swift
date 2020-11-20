@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    
    // Quality should be decreased by 1
    func testNormalItemQualityDecreaseByOneWhenQuantityIsGreaterThanZero() {
        let subject = GildedRose(items: [Item(name: "Normal Item", sellIn: 1, quality: 1)])
        subject.updateQuality()
        XCTAssertEqual(subject.items[0].quality, 0)
    }
    // Minimum Quality is zero
    func testNormalItemQualityNotChangeWhenQualityIsZero() {
        let subject = GildedRose(items: [Item(name: "Normal Item", sellIn: 1, quality: 0)])
        subject.updateQuality()
        XCTAssertEqual(subject.items[0].quality, 0)
    }
    // Backstage passess increase 10 days before the event
    func testBackstagePassesQualityIncreaseByTwoWhenQualityIsLessThan50AndSellInLessThan11() {
        let upComingEventDays = 10
        let subject = GildedRose(items: [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: upComingEventDays, quality: 48)])
        subject.updateQuality()
        XCTAssertEqual(subject.items[0].quality, 50)
    }
    // Backstage passess increase most before the event
    func testBackstageQualityIncreaseByThreeWhenQualityIsLessThan50AndSellInLessThan6() {
        let subject = GildedRose(items: [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 47)])
        subject.updateQuality()
        XCTAssertEqual(subject.items[0].quality, 50)
    }
    
    func testSellInShouldntDecreaseForSulfuras(){
        let subject = GildedRose(items: [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 3, quality: 4)])
        subject.updateQuality()
        XCTAssertEqual(subject.items[0].sellIn, 3)
    }
    
    func testNormalItemQualityAfterSellinDate() {
        let subject = GildedRose(items: [Item(name: "Normal Item", sellIn: -1, quality: 1)])
        subject.updateQuality()
        XCTAssertEqual(subject.items[0].quality, 0)
    }
    
}

