@testable import Movie_
import XCTest

final class MovieSearchVCTests: XCTestCase {

    var sut : MovieSearchVC!
    
    override func setUp() {
        super.setUp()
        sut = MovieSearchVC()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_outletsShouldBeConnected() {
        XCTAssertNotNil(sut.searchResultsTableView, "searchResultsTableView")
        XCTAssertNotNil(sut.searchBar, "searchBar")
    }
    
    func test_delegatesShouldBeConnected() {
        XCTAssertNotNil(sut.searchBar.delegate, "searchBar delegate")
        XCTAssertNotNil(sut.searchResultsTableView.delegate, "searchResultsTableView delegate")
        XCTAssertNotNil(sut.searchResultsTableView.dataSource, "searchResultsTableView dataSource")
    }
    
    func test_sutTitle_shouldBeSearch() {
        XCTAssertEqual(sut.title, "Search")
    }
    
    func test_searchBarPlaceholder_shouldBeSearchForMovies() {
        XCTAssertEqual(sut.searchBar.placeholder, "Search for Movies")
    }
    
    func test_searchBarCancelButton_shouldEnabled() {
        XCTAssertTrue(sut.searchBar.showsCancelButton, "showsCancelButton")
    }
}
