@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    let backStage = "Backstage passes to a TAFKAL80ETC concert"
    let regularItem = "foo"
    let agedBrie = "Aged Brie"
    
    func testRegularItemName() {
        let items = [Item(name: regularItem, sellIn: 0, quality: 0)]
        let app = setupWithItems(items)
        XCTAssertEqual(regularItem, app.items[0].name);
    }
    
    func testRegularItemQualityDegrades() {
        let items = [Item(name: regularItem, sellIn: 2, quality: 2)]
        let app = setupWithItems(items)
        XCTAssertEqual(app.items.first?.quality, 1)
    }
    
    func testAgedBrieQualityIncreases() {
        let items = [Item(name: agedBrie, sellIn: 1, quality: 0)]
        let app = setupWithItems(items)
        XCTAssertEqual(app.items.first?.quality, 1)
    }
    
    func testBackstagePassQualityIncreasesTenDays() {
        let items = [Item(name: backStage, sellIn: 15, quality: 4)]
        let app = setupWithItems(items)
        XCTAssertEqual(app.items.first?.quality, 5)
    }
    
    func testBackstagePassQualityIncreasesUnderTenDays() {
        let items = [Item(name: backStage, sellIn: 9, quality: 4)]
        let app = setupWithItems(items)
        XCTAssertEqual(app.items.first?.quality, 6)
    }
    
    func testBackstagePassQualityIncreasesUnderFiveDays() {
        let items = [Item(name: backStage, sellIn: 4, quality: 4)]
        let app = setupWithItems(items)
        XCTAssertEqual(app.items.first?.quality, 7)
    }
    
    func testRegularItemQualityDelegradeSellingLessThanZero() {
        let item = Item(name: regularItem, sellIn: -1, quality: 4)
        assertQualityOfItemChangesBy(item, -2)
    }
    
    func testAgedBrieQualityIncrease(){
        let item = Item(name: agedBrie, sellIn: -1, quality: 5)
        assertQualityOfItemChangesBy(item, 2)
    }
    
    func testQualityIsEqualToOrLessThanFifty(){
        let item = Item(name: agedBrie, sellIn: -1, quality: 49)
        assertQualityOfItemChangesBy(item, 1)
    }
    
    func testQualityOfBackstagePassesDoesNotExceedFifty(){
        let item = Item(name: backStage, sellIn: 1, quality: 48)
        assertQualityOfItemChangesBy(item, 2)
    }
    
    func testQualityOfBackstagePassesDoesNotExceedFiftySellIn8(){
        let item = Item(name: backStage, sellIn: 8, quality: 49)
        assertQualityOfItemChangesBy(item, 1)
    }
    
    func testQualityOfBackstagePassesDoesNotExceedFiftySellIn12(){
        let item = Item(name: backStage, sellIn: 12, quality: 50)
        assertQualityOfItemChangesBy(item, 0)
    }
    
    func testQualityNonNegative() {
        let item = Item(name: regularItem, sellIn: 5, quality: 0)
        assertQualityOfItemChangesBy(item, 0)
    }
    
    func testBackstagePassQualityIsWorthlessAfterEvent() {
//        let items = [Item(name: backStage, sellIn: 0, quality: 4)]
//        let app = setupWithItems(items)
//        XCTAssertEqual(app.items.first?.quality, 0)
        
        assertQualityOfItemChangesBy(.item(named: backStage, sellIn: 0, quality: 5), -5)
    }
    //helper function: pass in sell name, and quality change
    
    func assertQualityOfItemChangesBy(_ item : Item, _ qualityChange : Int)  {
        let originalQUality = item.quality
        setupWithItems([item])
        XCTAssertEqual(item.quality, originalQUality + qualityChange)
    }
    
    
    @discardableResult private func setupWithItems(_ items: [Item]) -> GildedRose {
        let app = GildedRose(items: items)
        app.updateQuality()
        return app
    }
}


private extension Item {
    static func item(named name: String, sellIn: Int, quality: Int = 25) -> Item {
        return Item(name: name, sellIn: sellIn, quality: quality)
    }
}
