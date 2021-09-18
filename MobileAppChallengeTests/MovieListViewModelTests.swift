import XCTest

fileprivate extension Movie {
    static func createTestMovie(index: Int) -> Movie {
        let jsonString = """
            {
                "Title":"\(index + 1)",
                "Year":"2019",
                "imdbID":"tt4154664",
                "Type":"movie",
                "Poster":"https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg"
            }
            """
        let jsonData = jsonString.data(using: .utf8)
        return try! JSONDecoder().decode(Movie.self, from: jsonData!)
    }
}

fileprivate class TestRepo: MovieListRepo {
    private var movies: [Movie]
    
    init(count: Int) {
        self.movies = Array(0..<count).map { Movie.createTestMovie(index: $0) }
    }
    
    func items(for string: String, page: Int, _ completionHandler: @escaping (_ items: Items?) -> Void) {
        completionHandler(Items(movies: movies, totalResults: movies.count))
    }
}

class MovieListViewModelTests: XCTestCase {

    func testNewSearch() {
        let vm = MovieListViewModel()
        vm.movieListRepo = TestRepo(count: 0)
        vm.newSearch(for: "")
        XCTAssertEqual(0, vm.numberOfRows)

        vm.movieListRepo = TestRepo(count: 1)
        vm.newSearch(for: "")
        XCTAssertEqual(1, vm.numberOfRows)
        
        vm.movieListRepo = TestRepo(count: 2)
        vm.newSearch(for: "")
        XCTAssertEqual(1, vm.numberOfRows)
        
        vm.movieListRepo = TestRepo(count: 3)
        vm.newSearch(for: "")
        XCTAssertEqual(2, vm.numberOfRows)
        
        vm.movieListRepo = TestRepo(count: 4)
        vm.newSearch(for: "")
        XCTAssertEqual(2, vm.numberOfRows)
        XCTAssertEqual(vm.moviesInRow(1)[0]?.title, "3")
        XCTAssertEqual(vm.moviesInRow(1)[1]?.title, "4")

    }
    
    func testNextPage() {
        let vm = MovieListViewModel()
        vm.movieListRepo = TestRepo(count: 3)
        vm.nextPage()
        XCTAssertEqual(2, vm.numberOfRows)

        vm.movieListRepo = TestRepo(count: 3)
        vm.nextPage()
        XCTAssertEqual(3, vm.numberOfRows)
        
        vm.movieListRepo = TestRepo(count: 5)
        vm.nextPage()
        XCTAssertEqual(6, vm.numberOfRows)
        XCTAssertEqual(vm.moviesInRow(5)[0]?.title, "5")
        XCTAssertNil(vm.moviesInRow(5)[1])
    }
}
