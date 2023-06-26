@testable import Movie_
import XCTest

final class MovieSearchVCTests: XCTestCase {

    var sut : MovieSearchVC!
    var presenter : MovieSearchPresenter!

    override func setUp() {
        super.setUp()
        presenter = MovieSearchPresenter()
        
        sut = MovieSearchVC()
        sut.presenter = presenter
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        presenter = nil
        sut = nil
        super.tearDown()
    }
    
    func test_outletsShouldBeConnected() {
        XCTAssertNotNil(sut.searchResultsTableView, "searchResultsTableView")
        XCTAssertNotNil(sut.searchBar, "searchBar")
    }
    
    func test_delegatesShouldBeConnected() {
        XCTAssertNotNil(sut.searchBar.delegate, "UISearchBarDelegate")
        XCTAssertNotNil(sut.searchResultsTableView.delegate, "UITableViewDelegate")
        XCTAssertNotNil(sut.searchResultsTableView.dataSource, "UITableViewDataSource")
        XCTAssertNotNil(sut.presenter.delegate, "MovieSearchPresenterDelegate")
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
    
    func test_clickSearchBarCancelButton_shouldResignKeyboard() {
        sut.searchBar.becomeFirstResponder()
        executeRunLoop()
        
        searchBarButtonCancelClicked(sut.searchBar)
        
        XCTAssertFalse(sut.searchBar.isFirstResponder)
    }
    
    func test_clickSearchBarCancelButton_shouldClearSearchText() {
        sut.searchBar.becomeFirstResponder()
        executeRunLoop()
        
        searchBarButtonCancelClicked(sut.searchBar)
        
        let searchBarTextIsEmpty = sut.searchBar.text?.isEmpty
        XCTAssertEqual(searchBarTextIsEmpty, true)
    }
    
    
}
