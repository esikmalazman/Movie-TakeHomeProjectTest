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
    
    func test_clickSearchBarSearchButton_shouldClearStoredExistingMovieList() {
        sut.searchBar.text = "Fake Query"
        
        searchBarSearchButtonClicked(sut.searchBar)
        
        XCTAssertEqual(sut.presenter.moviesList.count, 0)
    }
    
    func test_clickSearchBarSearchButton_shouldResignKeyboard() {
        sut.searchBar.text = "Fake Query"
        
        searchBarSearchButtonClicked(sut.searchBar)
        
        XCTAssertFalse(sut.searchBar.isFirstResponder)
    }
    
    func test_numberOfRows_withEmptyMovie_shouldDisplay0Rows() {
        sut.presenter.moviesList = []
        
        let searchResultRowsCount = numberOfRows(sut.searchResultsTableView)
        
        XCTAssertEqual(searchResultRowsCount, 0)
    }
    
    func test_numberOfRows_with1Movie_shouldDisplay1Row() {
        sut.presenter.moviesList = [
            Movie(id: 1, title: "Title 1", releaseDate: "Release Date 1", posterPath: "Poster Path 1"),
        ]
        
        let searchResultRowsCount = numberOfRows(sut.searchResultsTableView)
        
        XCTAssertEqual(searchResultRowsCount, 1)
    }
    
    func test_numberOfRows_with2Movies_shouldDisplay2Rows() {
        sut.presenter.moviesList = [
            Movie(id: 1, title: "Title 1", releaseDate: "Release Date 1", posterPath: "Poster Path 1"),
            Movie(id: 2, title: "Title 2", releaseDate: "Release Date 2", posterPath: "Poster Path 2"),
        ]
        
        let searchResultRowsCount = numberOfRows(sut.searchResultsTableView)
        
        XCTAssertEqual(searchResultRowsCount, 2)
    }
    
    func test_cellForRowAt_withRow0_shouldHaveTypeMovieResultCell() {
        sut.presenter.moviesList = [
            Movie(id: 1, title: "Title 1", releaseDate: "Release Date 1", posterPath: "Poster Path 1"),
        ]
        
        let cell = cellForRowAt(sut.searchResultsTableView, atRow: 0) as? MovieResultCell
        
        XCTAssertNotNil(cell)
    }
    
    func test_cellForRowAt_withRow0_shouldConfigureWithPropertyOf1() {
        sut.presenter.moviesList = [
            Movie(id: 1, title: "Title 1", releaseDate: "Release Date 1", posterPath: "Poster Path 1"),
        ]
        
        guard let cell = cellForRowAt(sut.searchResultsTableView, atRow: 0) as? MovieResultCell else {
            XCTFail("The cell expected to be \(MovieResultCell.self)")
            return
        }
        
        XCTAssertEqual(cell.titleLabel.text, "Title 1", "title")
        XCTAssertEqual(cell.releaseDateLabel.text, "Release Date 1", "releaseDate")
    }
    
    func test_cellForRowAt_withRow2_shouldConfigureWithPropertyOf3() {
        sut.presenter.moviesList = [
            Movie(id: 1, title: "Title 1", releaseDate: "Release Date 1", posterPath: "Poster Path 1"),
            Movie(id: 1, title: "Title 2", releaseDate: "Release Date 2", posterPath: "Poster Path 2"),
            Movie(id: 1, title: "Title 3", releaseDate: "Release Date 3", posterPath: "Poster Path 3"),
        ]
        
        guard let cell = cellForRowAt(sut.searchResultsTableView, atRow: 2) as? MovieResultCell else {
            XCTFail("The cell expected to be \(MovieResultCell.self)")
            return
        }
        
        XCTAssertEqual(cell.titleLabel.text, "Title 3", "title")
        XCTAssertEqual(cell.releaseDateLabel.text, "Release Date 3", "releaseDate")
    }
}
