@testable import Movie_
import XCTest

final class MovieSearchVCTests: XCTestCase {
    
    var sut : MovieSearchVC!
    
    override func setUp() {
        super.setUp()
        let presenter = MovieSearchPresenter()
        
        sut = MovieSearchVC()
        sut.presenter = presenter
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
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
    
    
    func test_clickSearchBarSearchButton_withNotEmptyQuery_shouldInsertQueryToRecentlySearchCollection() {
        sut.searchBar.text = "Fake Query"
        
        searchBarSearchButtonClicked(sut.searchBar)
        
        XCTAssertEqual(sut.presenter.recentlySearchQueries.count, 1)
        XCTAssertEqual(sut.presenter.recentlySearchQueries.first, "Fake Query")
    }
    
    func test_clickSearchBarSearchButton_withEmptyQuery_shouldNotInsertQueryToRecentlySearchCollection() {
        sut.searchBar.text = ""
        
        searchBarSearchButtonClicked(sut.searchBar)
        
        XCTAssertEqual(sut.presenter.recentlySearchQueries.count, 0)
    }
    
    func test_clickSearchBarSearchButton_shouldClearStoredExistingMovieList() {
        sut.searchBar.text = "Fake Query"
        
        searchBarSearchButtonClicked(sut.searchBar)
        
        XCTAssertEqual(sut.presenter.moviesList.count, 0)
    }
    
    // MARK:  TODO's
    // 1. To test requested movie flow, we might create protocol for presenter then create mock version of it
    // 2. To test the delegate and dataSource method of the table view
}
