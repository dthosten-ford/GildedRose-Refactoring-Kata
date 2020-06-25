@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    let backStage = "Backstage passes to a TAFKAL80ETC concert"
    let regularItem = "foo"
    let agedBrie = "Aged Brie"
    
    func testFoo() {
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
    

    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testFoo", testFoo),
        ]
    }
}


private extension Item {
    static func item(named name: String, sellIn: Int, quality: Int = 25) -> Item {
        return Item(name: name, sellIn: sellIn, quality: quality)
    }
}
